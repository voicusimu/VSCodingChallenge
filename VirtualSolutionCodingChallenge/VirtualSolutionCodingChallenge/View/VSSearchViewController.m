//
//  ViewController.m
//  VirtualSolutionCodingChallenge
//
//  Created by Simu Voicu-Mircea on 17.04.2022.
//

#import "VSSearchViewController.h"
#import <SDWebImage/SDWebImage.h>
#import "VSSearchResultTableViewCell.h"
#import "VSCustomLoadMoreFooterView.h"
#import "VSDetailsViewController.h"

@interface VSSearchViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic) BOOL isLoadingMore;

@end

@implementation VSSearchViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialSetup];
    // Do any additional setup after loading the view.
}


#pragma mark - Delegates and datasources

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    VSSearchResultTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"VSSearchResultTableViewCell"];

    if (cell == nil) {
        cell = [[VSSearchResultTableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:@"VSSearchResultTableViewCell"];
    }

    VSPixabayImageSearchResult *imageResult = [self.viewModel.datasource objectAtIndex: indexPath.row];

    cell.usernameLabel.text = [NSString stringWithFormat:@"Username: %@", imageResult.user];
    cell.tagsLabel.text = [NSString stringWithFormat:@"Tags: %@", imageResult.tags];
    [cell.thumbnailImageview sd_setImageWithURL: [[NSURL alloc] initWithString: imageResult.previewURL]
                               placeholderImage: [UIImage imageNamed: @"placeholder"]];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.viewModel.datasource count];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    VSCustomLoadMoreFooterView *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier: @"VSCustomLoadMoreFooterView"];
    [footer.activityIndicator startAnimating];

    if (self.isLoadingMore) {
        return footer;
    } else {
        return nil;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated: YES];
    VSPixabayImageSearchResult *searchResult = [self.viewModel.datasource objectAtIndex: indexPath.row];
    if ([self.delegate respondsToSelector:@selector(didSelectSearchResult:)]) {
        [self.delegate didSelectSearchResult: searchResult];
    }
    VSDetailsViewController *detailstViewController = (VSDetailsViewController *)self.delegate;
    [self.splitViewController showDetailViewController: detailstViewController sender: self];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat contentOffset = scrollView.contentOffset.y;
    CGFloat maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height;
    CGFloat threshold = 100.0;
    if (!self.isLoadingMore &&
        (maximumOffset - contentOffset <= threshold) &&
        ![self isSearchWordEmpty] &&
        [self.viewModel hasMoreResults]) {
        self.isLoadingMore = YES;
        [self.tableView reloadData];
        [self getNextPage];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing: YES];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [NSObject cancelPreviousPerformRequestsWithTarget: self
                                             selector: @selector(performNewSearch)
                                               object:nil];
    [self performSelector: @selector(performNewSearch)
               withObject: nil
               afterDelay: 0.5];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

- (BOOL)splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController {
    if ([secondaryViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController *)secondaryViewController;
        if ([navigationController.topViewController isKindOfClass:[VSDetailsViewController class]]) {
            VSDetailsViewController *detailViewController = (VSDetailsViewController *)navigationController.topViewController;
            return detailViewController.viewModel.searchResult == NULL;
        }
    }
    return NO;
}


#pragma mark - Private methods

- (void)performNewSearch {
    if ([self isSearchWordEmpty]) {
        [self resetSearch];
    } else {
        [self.viewModel searchForImagesWith: self.searchBar.text onSuccess:^{
            [self.tableView reloadData];
        } onFailure:^(NSError * _Nonnull error) {
            [self showErrorAlert];
            [self.tableView reloadData];
        }];
    }
}

- (void)getNextPage {
    if ([self.viewModel hasMoreResults]) {
        [self.viewModel getResultsForNextPage: self.searchBar.text onSuccess:^{
            self.isLoadingMore = NO;
            [self.tableView reloadData];
        } onFailure:^(NSError * _Nonnull error) {
            [self showErrorAlert];
            self.isLoadingMore = NO;
            [self.tableView reloadData];
        }];
    }
}

- (void)initialSetup {
    self.viewModel = [[VSSearchViewModel alloc] init];
    self.tableView.estimatedRowHeight = 100.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    UINib *nib = [UINib nibWithNibName:@"VSCustomLoadMoreFooterView" bundle:nil];
    [self.tableView registerNib: nib forHeaderFooterViewReuseIdentifier: @"VSCustomLoadMoreFooterView"];
    self.searchBar.text = @"Apples";
    [self performNewSearch];
}

- (void)resetSearch {
    [self.viewModel resetSearch];
    [self.tableView reloadData];
}

- (BOOL)isSearchWordEmpty {
    NSString *searchWord = self.searchBar.text;
    NSString *trimmedSearchWord = [searchWord stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];

    return trimmedSearchWord.length == 0;
}

- (void)showErrorAlert {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Error"
                                   message:@"Something went wrong. You might have network connection issues. Please try again..."
                                   preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
       handler:^(UIAlertAction * action) {}];

    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
