//
//  SessionContext.h
//  
//
//  Created by Alex Rozanski on 23/04/2023.
//

#import <Foundation/Foundation.h>

@interface _SessionContextToken : NSObject <NSCopying>

@property (nonatomic, readonly) int token;
@property (nonatomic, readonly, copy, nonnull) NSString *string;

- (nonnull instancetype)initWithToken:(int)token string:(NSString *__nonnull)string;

@end

@interface _SessionContext : NSObject <NSCopying>

@property (nonatomic, readonly, copy, nullable) NSString *contextString;
@property (nonatomic, readonly, copy, nullable) NSArray<_SessionContextToken *> *tokens;

- (nonnull instancetype)initWithTokens:(NSArray<_SessionContextToken *> *__nullable)tokens;

@end
