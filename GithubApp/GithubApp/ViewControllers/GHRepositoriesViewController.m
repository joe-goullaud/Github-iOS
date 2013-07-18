//
//  GHRepositoriesViewController.m
//  GithubApp
//
//  Created by Joe Goullaud on 7/16/13.
//  Copyright (c) 2013 Raizlabs. All rights reserved.
//

#import "GHRepositoriesViewController.h"
#import "GHIssuesViewController.h"
#import "RZCollectionList.h"
#import "GHDataManager.h"
#import "Repository.h"

@interface GHRepositoriesViewController () <RZCollectionListTableViewDataSourceDelegate>

@property (nonatomic, strong) id<RZCollectionList> reposList;
@property (nonatomic, strong) RZCollectionListTableViewDataSource *dataSource;

@end

@implementation GHRepositoriesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.reposList = [[GHDataManager defaultManager] reposForOrg:@"Raizlabs" completion:NULL];
    
    self.dataSource = [[RZCollectionListTableViewDataSource alloc] initWithTableView:self.tableView
                                                                      collectionList:self.reposList
                                                                            delegate:self];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [[GHDataManager defaultManager] reposForOrg:@"Raizlabs" completion:NULL];
}

#pragma mark - RZCollectionListTableViewDataSourceDelegate

- (UITableViewCell*)tableView:(UITableView *)tableView cellForObject:(Repository*)repo atIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RepoCellId"];
    
    if (nil == cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"RepoCellId"];
    }
    
    cell.textLabel.text = repo.name;
    cell.detailTextLabel.text = repo.repoDescription;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GHIssuesViewController *issuesVC = [[GHIssuesViewController alloc] init];
    
    Repository *repo = [self.reposList objectAtIndexPath:indexPath];
    
    issuesVC.repoFullName = repo.fullName;
    
    [self.navigationController pushViewController:issuesVC animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
