//
//  Repository.h
//  GithubApp
//
//  Created by Joe Goullaud on 7/16/13.
//  Copyright (c) 2013 Raizlabs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Repository : NSManagedObject

@property (nonatomic, retain) NSString * fullName;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * org;
@property (nonatomic, retain) NSString * repoDescription;
@property (nonatomic, retain) NSNumber * repoId;
@property (nonatomic, retain) NSString * user;
@property (nonatomic, retain) NSSet *issues;
@end

@interface Repository (CoreDataGeneratedAccessors)

- (void)addIssuesObject:(NSManagedObject *)value;
- (void)removeIssuesObject:(NSManagedObject *)value;
- (void)addIssues:(NSSet *)values;
- (void)removeIssues:(NSSet *)values;

@end
