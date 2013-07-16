//
//  GHWebServiceManager.m
//  GithubApp
//
//  Created by Joe Goullaud on 7/16/13.
//  Copyright (c) 2013 Raizlabs. All rights reserved.
//

#import "GHWebServiceManager.h"
#import "NSData+Base64.h"

@interface GHWebServiceManager ()

- (RZWebServiceRequestPreProcessBlock)authenticationBlock;

@end

@implementation GHWebServiceManager

+ (GHWebServiceManager*)defaultManager
{
    static GHWebServiceManager *_defaultManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *callsPath = [[NSBundle mainBundle] pathForResource:@"GithubAppWebService" ofType:@"plist"];
        _defaultManager = [[GHWebServiceManager alloc] initWithCallsPath:callsPath];
        
        _defaultManager.defaultHost = @"https://api.github.com/";
    });
    
    return _defaultManager;
}

- (RZWebServiceRequestPreProcessBlock)authenticationBlock
{
    __weak GHWebServiceManager *wself = self;
    
    RZWebServiceRequestPreProcessBlock authBlock = ^(RZWebServiceRequest *request) {
        NSString *basicAuthEncodedString = [[[NSString stringWithFormat:@"%@:%@", wself.username, wself.password] dataUsingEncoding:NSUTF8StringEncoding] base64EncodedString];
        NSString *authValue = [NSString stringWithFormat:@"Basic %@", basicAuthEncodedString];
        [request setValue:authValue forHTTPHeaderField:@"Authorization"];
    };
    
    return [authBlock copy];
}

- (RZWebServiceRequest*)requestReposForUser:(NSString*)user completion:(RZWebServiceRequestCompletionBlock)completion
{
    RZWebServiceRequest *request = [self requestWithParameters:nil enqueue:NO completion:completion formatKey:@"getReposForUser", user];
    
    request.preProcessBlocks = @[[self authenticationBlock]];
    
    [self enqueueRequest:request];
    
    return request;
}

- (RZWebServiceRequest*)requestReposForOrg:(NSString*)org completion:(RZWebServiceRequestCompletionBlock)completion
{
    RZWebServiceRequest *request = [self requestWithParameters:nil enqueue:NO completion:completion formatKey:@"getReposForOrg", org];
    
    request.preProcessBlocks = @[[self authenticationBlock]];
    
    [self enqueueRequest:request];
    
    return request;
}

- (RZWebServiceRequest*)requestIssuesForRepoFullName:(NSString*)repoFullName completion:(RZWebServiceRequestCompletionBlock)completion
{
    RZWebServiceRequest *request = [self requestWithParameters:nil enqueue:NO completion:completion formatKey:@"getIssuesForRepoFullName", repoFullName];
    
    request.preProcessBlocks = @[[self authenticationBlock]];
    
    [self enqueueRequest:request];
    
    return request;
}

@end
