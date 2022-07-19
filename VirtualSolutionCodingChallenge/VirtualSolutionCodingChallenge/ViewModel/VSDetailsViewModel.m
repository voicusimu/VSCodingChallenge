//
//  VSDetailsViewModel.m
//  VirtualSolutionCodingChallenge
//
//  Created by Simu Voicu-Mircea on 17.04.2022.
//

#import "VSDetailsViewModel.h"

@implementation VSDetailsViewModel

- (instancetype)initWithSearchResult:(VSPixabayImageSearchResult*)searchResult {
    self = [super init];
    if (self) {
        self.searchResult = searchResult;
    }
    return self;
}

@end
