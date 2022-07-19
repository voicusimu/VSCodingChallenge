//
//  VSSearchViewModel.h
//  VirtualSolutionCodingChallenge
//
//  Created by Simu Voicu-Mircea on 17.04.2022.
//

#import <Foundation/Foundation.h>
#import "VSImageSearchService.h"
#import "VSPixabaySearchResult.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^ImageSearchCompletionBlock)(void);
typedef void (^_Nullable FailureCompletionBlock)(NSError *error);

@interface VSSearchViewModel : NSObject

@property (nonatomic, strong) NSMutableArray <VSPixabayImageSearchResult> *datasource;
@property (nonatomic) NSInteger page;
@property (nonatomic) NSInteger totalHits;

- (void)searchForImagesWith:(NSString*)keyword onSuccess: (ImageSearchCompletionBlock)successBlock onFailure: (FailureCompletionBlock)failureBlock;
- (void)getResultsForNextPage:(NSString*)keyword onSuccess: (ImageSearchCompletionBlock)successBlock onFailure: (FailureCompletionBlock)failureBlock;
- (void)resetSearch;
- (BOOL)hasMoreResults;

@end

NS_ASSUME_NONNULL_END
