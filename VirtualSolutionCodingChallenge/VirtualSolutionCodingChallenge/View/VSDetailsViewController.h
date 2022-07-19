//
//  VSDetailsViewController.h
//  VirtualSolutionCodingChallenge
//
//  Created by Simu Voicu-Mircea on 17.04.2022.
//

#import <UIKit/UIKit.h>
#import "VSDetailsViewModel.h"
#import "VSSearchViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface VSDetailsViewController : UIViewController <VSSearchViewControllerDelegate>

@property (nonatomic, strong) VSDetailsViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

NS_ASSUME_NONNULL_END
