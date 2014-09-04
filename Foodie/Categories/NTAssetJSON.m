//
//  NTAssetsJSON.m
//
//  Created by Manish Kumar - Imported on 3/31/14.
//
//

#import "NTAssetJSON.h"
#import "NTJSON.h"
#import "AppDelegate.h"

@implementation Asset
+(NTAssetJSON *)json
{
    return theAppDelegate.assets;
}
@end

@interface NTAssetJSON ()
@property (nonatomic, strong) NSDictionary *assetsCommon;
@property (nonatomic, strong) NSDictionary *assetsDevice;
@end

@implementation NTAssetJSON


+ (NSDictionary *)loadJSON:(NSString *)filePath
{
    NSString *path = [[NSBundle mainBundle] pathForResource:filePath ofType:nil];
	NSString *json = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    
    //Our json may have comments - something that json does not support.
    //so we have this little function which removes the comments from
    //the json before we actually hand it off to the json parser.
	
	// I have commented out the comment striping code.  This was taking 5 seconds on app launch (out of 8 seoncds)
	// Removing this line of code (and comments form the JSON files) takes the app launch time from 8 seconds to 3 seconds.
//    json = [json stripCommentsFromJSON];

	NSData *data = [json dataUsingEncoding:NSUTF8StringEncoding];
    if (data) {
        NSError *error;
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error: &error];
        if (error == nil)
            return jsonDict;
        else{
            @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                           reason:[NSString stringWithFormat:@"Invalid JSON %@", json]
                                         userInfo:nil];
        }
    }
    return nil;
}

- (id) initWithFilePrefix:(NSString *)filePrefix
{
    self = [super init];
    if (UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPhone)
        self.assetsDevice = [self.class loadJSON:[NSString stringWithFormat:@"%@~iPhone.json", filePrefix]];
    else
        self.assetsDevice = [self.class loadJSON:[NSString stringWithFormat:@"%@~iPad.json", filePrefix]];
    self.assetsCommon = [self.class loadJSON:[NSString stringWithFormat:@"%@.json", filePrefix]];
    return self;
}

//this function is a little fragile with merges.
//it assumes that the two objects have the same structure
//i.e. you cannot merge an array or a string into a dictionary.
//if you try something funky, please validate the output.
- (id)objectForKeyedSubscript:(NSString *)key
{
    if (key == nil) 
        return nil;
    
    id objDevice = [self.assetsDevice valueForKeyPath:key];
    if (objDevice == nil) {
        id objCommon = [self.assetsCommon valueForKeyPath:key];
        if ([objCommon isKindOfClass:[NSDictionary class]])
            return [NTJSON dictionary:objCommon];
        if ([objCommon isKindOfClass:[NSArray class]])
            return [NTJSON array:objCommon];
        
        return objCommon;
    }
	if ([objDevice isKindOfClass:[NSDictionary class]]) {
        id objCommon = [self.assetsCommon valueForKeyPath:key];
        if ([objCommon isKindOfClass:[NSDictionary class]]) {
            //merge: Note that this is not a deep-merge.  Use with care.
            //we merge only one level deep.  And that too if the level is a dictionary.
            NSDictionary *dictDevice = (NSDictionary *)objDevice;
            NSDictionary *dictCommon = (NSDictionary *)objCommon;
            
            NSMutableDictionary *dict = [dictCommon mutableCopy];
            [dictDevice enumerateKeysAndObjectsUsingBlock:^(id keyDevice, id valueDevice, BOOL *stop1) {
                if ([valueDevice isKindOfClass:[NSDictionary class]]) {
                    id valueCommon = [dict objectForKey:keyDevice];
                    if ([valueCommon isKindOfClass:[NSDictionary class]]) {
                        //we need to stitch the two together.
                        NSDictionary *dictValueCommon = (NSDictionary *)valueCommon;
                        NSDictionary *dictValueDevice = (NSDictionary *)valueDevice;
                        
                        NSMutableDictionary *dictValue = [dictValueCommon mutableCopy];
                        [dictValueDevice enumerateKeysAndObjectsUsingBlock:^(id k, id v, BOOL *stop2) {
                            dictValue[k] = v;
                        }];
                        dict[keyDevice] = dictValue;
                    }
                    else{
                        dict[keyDevice] = valueDevice;
                    }
                }
                else{
                    dict[keyDevice] = valueDevice;
                }
            }];
            
            return [NTJSON dictionary:dict];
        }
    }
	if ([objDevice isKindOfClass:[NSArray class]])
        return [NTJSON array:objDevice];
    
    return objDevice;
}

@end
