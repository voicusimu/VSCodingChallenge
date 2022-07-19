//
//  ViewController.h
//  VirtualSolutionCodingChallenge
//
//  Created by Simu Voicu-Mircea on 17.04.2022.
//

#import <UIKit/UIKit.h>
#import "VSSearchViewModel.h"

@protocol VSSearchViewControllerDelegate <NSObject>

- (void)didSelectSearchResult:(VSPixabayImageSearchResult *)searchResult;

@end

@interface VSSearchViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UIScrollViewDelegate, UISplitViewControllerDelegate>

@property (nonatomic, strong) VSSearchViewModel *viewModel;
@property (nonatomic, weak) id <VSSearchViewControllerDelegate> delegate;

@end

