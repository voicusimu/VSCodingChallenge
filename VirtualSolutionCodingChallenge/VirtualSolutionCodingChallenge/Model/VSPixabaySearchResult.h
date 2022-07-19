//
//  VSPixabaySearchResult.h
//  VirtualSolutionCodingChallenge
//
//  Created by Simu Voicu-Mircea on 17.04.2022.
//

#import <JSONModel/JSONModel.h>

NS_ASSUME_NONNULL_BEGIN

@protocol VSPixabayImageSearchResult @end

@interface VSPixabayImageSearchResult : JSONModel

@property (nonatomic) NSInteger id;
@property (nonatomic) NSString *pageURL;
@property (nonatomic) NSString *type;

@property (nonatomic) NSString *tags;

@property (nonatomic) NSString *previewURL;
@property (nonatomic) NSInteger previewWidth;
@property (nonatomic) NSInteger previewHeight;

@property (nonatomic) NSString *webformatURL;
@property (nonatomic) NSInteger webformatWidth;
@property (nonatomic) NSInteger webformatHeight;

@property (nonatomic) NSString *largeImageURL;
@property (nonatomic) NSString <Optional> *fullHDURL;
@property (nonatomic) NSString <Optional> *imageURL;

@property (nonatomic) NSInteger imageWidth;
@property (nonatomic) NSInteger imageHeight;
@property (nonatomic) NSInteger imageSize;

@property (nonatomic) NSInteger views;
@property (nonatomic) NSInteger downloads;
@property (nonatomic) NSInteger likes;
@property (nonatomic) NSInteger comments;

@property (nonatomic) NSInteger user_id;
@property (nonatomic) NSString *user;
@property (nonatomic) NSString <Optional> *userImageURL;

@end

@interface VSPixabaySearchResults : JSONModel

@property (nonatomic) NSInteger total;
@property (nonatomic) NSInteger totalHits;
@property (nonatomic) NSArray<VSPixabayImageSearchResult *> <VSPixabayImageSearchResult> *hits;

@end

NS_ASSUME_NONNULL_END
