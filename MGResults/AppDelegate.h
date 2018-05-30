//
//  AppDelegate.h
//  MGResults
//
//  Created by macmini on 6/6/17.
//  Copyright © 2017 CST. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;
@property NSMutableArray*result;

@end

