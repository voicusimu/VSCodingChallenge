//
//  VSImageSearchService.m
//  VirtualSolutionCodingChallenge
//
//  Created by Simu Voicu-Mircea on 17.04.2022.
//

#import "VSImageSearchService.h"
#import "AFNetworking.h"

@implementation VSImageSearchService

- (void)imageSearchWithWord:(NSString *)keyword forPage:(NSInteger)page onSuccess:(SuccessCompletionBlock)successBlock onFailure:(FailureCompletionBlock)failureBlock {
    NSURL *urlStr = [NSURL URLWithString: @"https://pixabay.com/api/"];

    NSDictionary *dictParameters = @{@"key" : @"26813725-d4fbacf90a7423ae9a31cd32b",
                                     @"q" : keyword,
                                     @"page" : @(page)
                                    };

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];


    [manager GET:urlStr.absoluteString parameters:dictParameters success:^(NSURLSessionTask *task, id responseObject) {
        successBlock(responseObject);
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        failureBlock(error);

    }];
}

@end
