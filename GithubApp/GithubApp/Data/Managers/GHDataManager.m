//
//  GHDataManager.m
//  GithubApp
//
//  Created by Joe Goullaud on 7/16/13.
//  Copyright (c) 2013 Raizlabs. All rights reserved.
//

#import "GHDataManager.h"
#import "GHWebServiceManager.h"
#import "RZCollectionList.h"

#import "Repository.h"
#import "Issue.h"

#import "NSFetchRequest+RZCreationHelpers.h"

@implementation GHDataManager

- (id)init
{
    if ((self = [super init]))
    {
        self.managedObjectModelName = @"GithubAppModel";
    }
    
    return self;
}

- (id<RZCollectionList>)reposForUser:(NSString*)user completion:(GHDataManagerCompletionBlock)completion
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Repository" sortDescriptorKey:@"name" ascending:YES predicateFormat:@"user == %@", user];
    NSFetchedResultsController *reposController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                                      managedObjectContext:self.managedObjectContext
                                                                                        sectionNameKeyPath:nil
                                                                                                 cacheName:nil];
    RZFetchedCollectionList *reposList = [[RZFetchedCollectionList alloc] initWithFetchedResultsController:reposController];
    
    [[GHWebServiceManager defaultManager] requestReposForUser:user completion:^(BOOL succeeded, id data, NSError *error, RZWebServiceRequest *request) {
        
        if ([data isKindOfClass:[NSArray class]])
        {
            [self importInBackgroundUsingBlock:^(NSManagedObjectContext *moc) {
                
                [data enumerateObjectsUsingBlock:^(NSDictionary *repoData, NSUInteger idx, BOOL *stop) {
                    Repository *repo = [self objectForEntity:@"Repository"
                                                   withValue:[repoData objectForKey:@"id"]
                                                  forKeyPath:@"repoId"
                                                    usingMOC:moc
                                                      create:YES];
                    
                    repo.repoId = [repoData objectForKey:@"id"];
                    repo.name = [repoData objectForKey:@"name"];
                    repo.fullName = [repoData objectForKey:@"full_name"];
                    repo.repoDescription = [repoData objectForKey:@"description"];
                    repo.user = user;
                }];
                
            } completion:^{
                
                if (completion)
                {
                    completion(YES, nil);
                }
                
            }];
        }
        else if (completion)
        {
            completion(NO, error);
        }
        
    }];
    
    return reposList;
}

- (id<RZCollectionList>)reposForOrg:(NSString*)org completion:(GHDataManagerCompletionBlock)completion
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Repository" sortDescriptorKey:@"name" ascending:YES predicateFormat:@"org == %@", org];
    NSFetchedResultsController *reposController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                                      managedObjectContext:self.managedObjectContext
                                                                                        sectionNameKeyPath:nil
                                                                                                 cacheName:nil];
    RZFetchedCollectionList *reposList = [[RZFetchedCollectionList alloc] initWithFetchedResultsController:reposController];
    
    [[GHWebServiceManager defaultManager] requestReposForOrg:org completion:^(BOOL succeeded, id data, NSError *error, RZWebServiceRequest *request) {
        
        if ([data isKindOfClass:[NSArray class]])
        {
            [self importInBackgroundUsingBlock:^(NSManagedObjectContext *moc) {
                
                [data enumerateObjectsUsingBlock:^(NSDictionary *repoData, NSUInteger idx, BOOL *stop) {
                    Repository *repo = [self objectForEntity:@"Repository"
                                                   withValue:[repoData objectForKey:@"id"]
                                                  forKeyPath:@"repoId"
                                                    usingMOC:moc
                                                      create:YES];
                    
                    repo.repoId = [repoData objectForKey:@"id"];
                    repo.name = [repoData objectForKey:@"name"];
                    repo.fullName = [repoData objectForKey:@"full_name"];
                    repo.repoDescription = [repoData objectForKey:@"description"];
                    repo.org = org;
                }];
                
            } completion:^{
                
                if (completion)
                {
                    completion(YES, nil);
                }
                
            }];
        }
        else if (completion)
        {
            completion(NO, error);
        }
        
    }];
    
    return reposList;
}

- (id<RZCollectionList>)issuesForRepoFullName:(NSString*)repoFullName completion:(GHDataManagerCompletionBlock)completion
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Issue" sortDescriptorKey:@"issueId" ascending:YES predicateFormat:@"repository.fullName == %@", repoFullName];
    NSFetchedResultsController *reposController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                                      managedObjectContext:self.managedObjectContext
                                                                                        sectionNameKeyPath:nil
                                                                                                 cacheName:nil];
    RZFetchedCollectionList *reposList = [[RZFetchedCollectionList alloc] initWithFetchedResultsController:reposController];
    
    [[GHWebServiceManager defaultManager] requestIssuesForRepoFullName:repoFullName  completion:^(BOOL succeeded, id data, NSError *error, RZWebServiceRequest *request) {
        
        if ([data isKindOfClass:[NSArray class]])
        {
            [self importInBackgroundUsingBlock:^(NSManagedObjectContext *moc) {
                
                Repository *repo = [self objectForEntity:@"Repository" withValue:repoFullName forKeyPath:@"fullName" usingMOC:moc create:NO];
                
                [data enumerateObjectsUsingBlock:^(NSDictionary *issueData, NSUInteger idx, BOOL *stop) {
                    Issue *issue = [self objectForEntity:@"Issue"
                                                   withValue:[issueData objectForKey:@"number"]
                                                  forKeyPath:@"issueId"
                                                    usingMOC:moc
                                                      create:YES];
                    
                    issue.issueId = [issueData objectForKey:@"number"];
                    issue.title = [issueData objectForKey:@"title"];
                    issue.issueDescription = [issueData objectForKey:@"body"];
                    
                    issue.repository = repo;
                    
                    
                }];
                
            } completion:^{
                
                if (completion)
                {
                    completion(YES, nil);
                }
                
            }];
        }
        else if (completion)
        {
            completion(NO, error);
        }
        
    }];
    
    return reposList;
}

@end
