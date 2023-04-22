//
//  SessionContext.m
//  
//
//  Created by Alex Rozanski on 23/04/2023.
//

#import "SessionContext.h"

static NSArray *deepCopyTokens(NSArray<_SessionContextToken *> *tokens) {
  NSMutableArray *deepCopiedTokens = [[NSMutableArray alloc] initWithCapacity:tokens.count];
  for (NSNumber *token in tokens) {
    [deepCopiedTokens addObject:[token copy]];
  }
  return [deepCopiedTokens copy];
}

@implementation _SessionContextToken

- (nonnull instancetype)initWithToken:(int)token string:(NSString *__nonnull)string
{
  if ((self = [super init])) {
    _token = token;
    _string = [string copy];
  }
  return self;
}

- (id)copyWithZone:(nullable NSZone *)zone
{
  return [[_SessionContextToken alloc] initWithToken:_token string:_string];
}

@end

@implementation _SessionContext {
  NSString *_contextString;
}

- (instancetype)initWithTokens:(NSArray<_SessionContextToken *> *)tokens
{
  if ((self = [super init])) {
    _tokens = deepCopyTokens(tokens);
  }
  return self;
}

- (id)copyWithZone:(nullable NSZone *)zone
{
  return [[_SessionContext alloc] initWithTokens:_tokens];
}

- (NSString *)contextString
{
  if (_contextString != nil) {
    return _contextString;
  }

  NSMutableString *contextString = [[NSMutableString alloc] init];
  for (_SessionContextToken *token in _tokens) {
    if (token.string != nil) {
      [contextString appendString:token.string];
    }
  }

  _contextString = [contextString copy];

  return _contextString;
}

@end

