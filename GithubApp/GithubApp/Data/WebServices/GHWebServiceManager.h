//
//  GHWebServiceManager.h
//  GithubApp
//
//  Created by Joe Goullaud on 7/16/13.
//  Copyright (c) 2013 Raizlabs. All rights reserved.
//

#import "RZWebServiceManager.h"

@interface GHWebServiceManager : RZWebServiceManager

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *password;

+ (GHWebServiceManager*)defaultManager;

- (RZWebServiceRequest*)requestReposForUser:(NSString*)user completion:(RZWebServiceRequestCompletionBlock)completion;
- (RZWebServiceRequest*)requestReposForOrg:(NSString*)org completion:(RZWebServiceRequestCompletionBlock)completion;

- (RZWebServiceRequest*)requestIssuesForRepoFullName:(NSString*)repoFullName completion:(RZWebServiceRequestCompletionBlock)completion;

@end
