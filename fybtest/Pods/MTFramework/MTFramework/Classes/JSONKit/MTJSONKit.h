//
//  MTJSONKit.h
//  MTFramework
//
//  Created by Jason Li on 2018/4/18.
//

#import <Foundation/Foundation.h>

//MARK: - Deserializing methods
@interface NSString (MTJSONKitDeserializing)
- (id)objectFromJSONString;
- (id)mutableObjectFromJSONString;
- (id)fragmentObjectFromJSONString;

@end

@interface NSData (MTJSONKitDeserializing)
// The NSData MUST be UTF8 encoded JSON.
- (id)objectFromJSONData;
- (id)mutableObjectFromJSONData;
- (id)fragmentObjectFromJSONData;
- (id)mutableLeavesFromJSONData;

@end

//MARK: - Serializing methods
@interface NSString (MTJSONKitSerializing)
- (NSData *)JSONData;

@end

@interface NSArray (MTJSONKitSerializing)
- (NSData *)JSONData;
- (NSString *)JSONString;

@end

@interface NSDictionary (MTJSONKitSerializing)
- (NSData *)JSONData;
- (NSString *)JSONString;

@end
