//
//  VSDetailsViewController.m
//  VirtualSolutionCodingChallenge
//
//  Created by Simu Voicu-Mircea on 17.04.2022.
//

#import "VSDetailsViewController.h"
#import "VSDetailsViewModel.h"
#import "VSDetailsTableViewCell.h"
#import <SDWebImage/SDWebImage.h>

@interface VSDetailsViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation VSDetailsViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.viewModel = [[VSDetailsViewModel alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialSetup];
    // Do any additional setup after loading the view.
}


- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.viewModel.searchResult == nil) {
        return 0;
    }
     return 1;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    VSDetailsTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"VSDetailsTableViewCell"];

    if (cell == nil) {
        cell = [[VSDetailsTableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:@"VSDetailsTableViewCell"];
    }

    [cell.customImageView sd_setImageWithURL: [[NSURL alloc] initWithString: self.viewModel.searchResult.largeImageURL]
                            placeholderImage: [UIImage imageNamed: @"placeholder"]];
    cell.userLabel.text = [NSString stringWithFormat:@"Username: %@", self.viewModel.searchResult.user];
    cell.tagsLabel.text = [NSString stringWithFormat:@"Tags: %@", self.viewModel.searchResult.tags];
    cell.likesLabel.text = [NSString stringWithFormat:@"%li likes", self.viewModel.searchResult.likes];
    cell.downloadsLabel.text = [NSString stringWithFormat:@"%li downloads", self.viewModel.searchResult.downloads];
    cell.commentsLabel.text = [NSString stringWithFormat:@"%li comments", self.viewModel.searchResult.comments];

    return cell;
}

- (void)initialSetup {
    self.tableView.estimatedRowHeight = 500.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

- (void)didSelectSearchResult:(VSPixabayImageSearchResult *)searchResult {
    self.viewModel.searchResult = searchResult;
    [self.tableView reloadData];
}

@end
