//
//  VSSearchViewModel.m
//  VirtualSolutionCodingChallenge
//
//  Created by Simu Voicu-Mircea on 17.04.2022.
//

#import "VSSearchViewModel.h"

@interface VSSearchViewModel()

@property (nonatomic, strong) VSImageSearchService *searchService;

@end

@implementation VSSearchViewModel

#pragma mark - Lifecycle

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.searchService = [[VSImageSearchService alloc] init];
        self.datasource = [[NSMutableArray<VSPixabayImageSearchResult> alloc] init];
        self.page = 1;
    }
    return self;
}

#pragma mark - Private methods

- (void)searchFor:(NSString*)keyword onSuccess: (ImageSearchCompletionBlock)successBlock onFailure: (FailureCompletionBlock)failureBlock {
    [self.searchService imageSearchWithWord: keyword
                                    forPage: self.page
      onSuccess:^(id  _Nonnull responseObject) {
        NSError *error;
        VSPixabaySearchResults *searchResults = [[VSPixabaySearchResults alloc] initWithDictionary:responseObject error:&error];
        if (error == nil) {
            self.totalHits = searchResults.totalHits;
            [self.datasource addObjectsFromArray: searchResults.hits];
            successBlock();
        } else {
            failureBlock(error);
        }
    } onFailure:^(NSError * _Nonnull error) {
        failureBlock(error);
    }];
}

#pragma mark - Public methods

- (void)searchForImagesWith:(NSString*)keyword onSuccess: (ImageSearchCompletionBlock)successBlock onFailure: (FailureCompletionBlock)failureBlock {
    [self.datasource removeAllObjects];
    self.page = 1;
    [self searchFor: keyword onSuccess: successBlock onFailure: failureBlock];
}

- (void)getResultsForNextPage:(NSString*)keyword onSuccess: (ImageSearchCompletionBlock)successBlock onFailure: (FailureCompletionBlock)failureBlock {
    self.page++;
    [self searchFor: keyword onSuccess: successBlock onFailure: failureBlock];
}

- (void)resetSearch {
    [self.datasource removeAllObjects];
    self.page = 1;
}

- (BOOL)hasMoreResults {
    return [self.datasource count] < self.totalHits;
}

@end
