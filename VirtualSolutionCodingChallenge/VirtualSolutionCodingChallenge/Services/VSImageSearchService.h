//
//  VSImageSearchService.h
//  VirtualSolutionCodingChallenge
//
//  Created by Simu Voicu-Mircea on 17.04.2022.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^_Nullable SuccessCompletionBlock)(id responseObject);
typedef void (^_Nullable FailureCompletionBlock)(NSError *error);

@interface VSImageSearchService : NSObject

- (void)imageSearchWithWord:(NSString *)keyword forPage:(NSInteger)page onSuccess:(SuccessCompletionBlock)successBlock onFailure:(FailureCompletionBlock)failureBlock;

@end

NS_ASSUME_NONNULL_END
