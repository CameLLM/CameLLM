//
//  CameLLMError.h
//
//
//  Created by Alex Rozanski on 22/04/2023.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString *const _CameLLMErrorDomain;

typedef NS_ENUM(NSInteger, _CameLLMErrorCode) {
  _CameLLMErrorCodeUnknown = -1,

  // High-level error codes
  _CameLLMErrorCodeFailedToValidateModel = -100,
  _CameLLMErrorCodeFailedToLoadModel = -101,
  _CameLLMErrorCodeFailedToPredict = -102,
  _CameLLMErrorCodeFailedToLoadSessionContext = -103,

  // General error codes
  _CameLLMErrorCodeInvalidInputArguments = -500,

  // Model internal error codes
  _CameLLMErrorCodeFailedToGetModelType = -1000,
  _CameLLMErrorCodeFailedToOpenModelFile = -1001,
  _CameLLMErrorCodeInvalidModelUnversioned = -1002,
  _CameLLMErrorCodeInvalidModelBadMagic = -1003,
  _CameLLMErrorCodeInvalidModelUnsupportedFileVersion = -1004,

  // General failure error codes
  _CameLLMErrorCodeGeneralInternalLoadFailure = -10001,
  _CameLLMErrorCodeGeneralInternalPredictionFailure = -10002,
};

NS_ASSUME_NONNULL_END
