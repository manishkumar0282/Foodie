//
//  NTAssetsJSON.h
//
//  Created by Manish Kumar - Imported on 3/31/14.
//
//

#import <Foundation/Foundation.h>

@interface NTAssetJSON : NSObject

- (id)objectForKeyedSubscript:(NSString *)key;

- (id) initWithFilePrefix:(NSString *)filePrefix;

@end

@interface Asset : NSObject

+(NTAssetJSON *)json;

@end
