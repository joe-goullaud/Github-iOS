//
//  GHIssuesViewController.m
//  GithubApp
//
//  Created by Joe Goullaud on 7/16/13.
//  Copyright (c) 2013 Raizlabs. All rights reserved.
//

#import "GHIssuesViewController.h"
#import "GHDataManager.h"
#import "RZCollectionList.h"
#import "Issue.h"

@interface GHIssuesViewController () <RZCollectionListTableViewDataSourceDelegate>

@property (nonatomic, strong) id<RZCollectionList> issuesList;
@property (nonatomic, strong) RZCollectionListTableViewDataSource *dataSource;

@end

@implementation GHIssuesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.issuesList = [[GHDataManager defaultManager] issuesForRepoFullName:self.repoFullName completion:NULL];
    
    self.dataSource = [[RZCollectionListTableViewDataSource alloc] initWithTableView:self.tableView collectionList:self.issuesList delegate:self];
}

#pragma mark - RZCollectionListTableViewDataSourceDelegate

- (UITableViewCell*)tableView:(UITableView *)tableView cellForObject:(Issue*)issue atIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IssueCellId"];
    
    if (nil == cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"IssueCellId"];
    }
    
    cell.textLabel.text = issue.title;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",issue.issueId];
    
    return cell;
}


@end
