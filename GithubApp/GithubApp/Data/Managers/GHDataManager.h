//
//  GHDataManager.h
//  GithubApp
//
//  Created by Joe Goullaud on 7/16/13.
//  Copyright (c) 2013 Raizlabs. All rights reserved.
//

#import "RZDataManager.h"

@protocol RZCollectionList;

typedef void (^GHDataManagerCompletionBlock)(BOOL succeeded, NSError *error);

@interface GHDataManager : RZDataManager

- (id<RZCollectionList>)reposForUser:(NSString*)user completion:(GHDataManagerCompletionBlock)completion;

- (id<RZCollectionList>)reposForOrg:(NSString*)org completion:(GHDataManagerCompletionBlock)completion;

- (id<RZCollectionList>)issuesForRepoFullName:(NSString*)repoFullName completion:(GHDataManagerCompletionBlock)completion;

@end
