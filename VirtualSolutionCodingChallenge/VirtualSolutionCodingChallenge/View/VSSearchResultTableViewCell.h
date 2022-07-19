//
//  VSSearchResultTableViewCell.h
//  VirtualSolutionCodingChallenge
//
//  Created by Simu Voicu-Mircea on 17.04.2022.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VSSearchResultTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *thumbnailImageview;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tagsLabel;

@end

NS_ASSUME_NONNULL_END
