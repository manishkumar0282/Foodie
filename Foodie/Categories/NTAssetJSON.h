//
//  NTAssetsJSON.h
//
//  Created by Navi Singh on 3/31/14.
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
