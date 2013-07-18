//
//  Issue.h
//  GithubApp
//
//  Created by Joe Goullaud on 7/16/13.
//  Copyright (c) 2013 Raizlabs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Repository;

@interface Issue : NSManagedObject

@property (nonatomic, retain) NSNumber * issueId;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * issueDescription;
@property (nonatomic, retain) NSNumber * isOpen;
@property (nonatomic, retain) Repository *repository;

@end
