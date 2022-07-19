//
//  VSDetailsViewModel.h
//  VirtualSolutionCodingChallenge
//
//  Created by Simu Voicu-Mircea on 17.04.2022.
//

#import <Foundation/Foundation.h>
#import "VSPixabaySearchResult.h"

NS_ASSUME_NONNULL_BEGIN

@interface VSDetailsViewModel : NSObject

@property (nonatomic, strong) VSPixabayImageSearchResult *searchResult;

- (instancetype)initWithSearchResult:(VSPixabayImageSearchResult*)searchResult;

@end

NS_ASSUME_NONNULL_END
