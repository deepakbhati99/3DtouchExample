//
//  AppDelegate.m
//  viewAnimations
//
//  Created by Himanshu Khatri on 1/12/16.
//  Copyright © 2016 bd 001. All rights reserved.
//

#import "AppDelegate.h"
#import "DetailViewController.h"
#import "MasterViewController.h"
@import Photos;
@import PhotosUI;
@import MobileCoreServices;
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
    MasterViewController *master=navigationController.viewControllers[0];
    [[NSNotificationCenter defaultCenter] addObserver:master selector:@selector(showAnimation:) name:UIApplicationLaunchOptionsShortcutItemKey object:nil];
    
    BOOL isLaunchedFromQuickAction = false;

    UIApplicationShortcutItem *shortcutItem=launchOptions[UIApplicationLaunchOptionsShortcutItemKey];
    
    // Check if it's launched from shortcutItem
    if (shortcutItem){
        isLaunchedFromQuickAction = true;
        
        // Handle the sortcutItem with required Action
        [self handleQuickAction:shortcutItem];
    }
    else{
        
    }
    
    NSArray <UIApplicationShortcutItem*> *existingShortcutItems=application.shortcutItems;
    //adding the dynamicShortcutItems if not exists
    if (!existingShortcutItems.count) {
        //custom method for updating the shortcutItems
        [self updateShortCutItems:@"Transition" and:@"Pulse"];
    }


    // Return false if the app was launched from a shortcut, so performActionForShortcutItem will not be called.
    return !isLaunchedFromQuickAction;


}

- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void(^)(BOOL succeeded))completionHandler{
    
    BOOL returnBoool=[self handleQuickAction:shortcutItem];

    completionHandler(returnBoool);
    
}



-(BOOL)handleQuickAction:(UIApplicationShortcutItem *)shortcutItem{
    
    BOOL quickActionHandled = false;
    NSString *type = [shortcutItem.type componentsSeparatedByString:@"."].lastObject;

    NSInteger selectedIndex;
    
    if ([type isEqual:@"simple"]) {
        selectedIndex=0;
        quickActionHandled = true;
    }else if ([type isEqual:@"bounce"]){
        selectedIndex=1;
        quickActionHandled = true;
    }else if ([type isEqual:@"transition"]){
        selectedIndex=2;
        quickActionHandled = true;
    
        [self updateShortCutItems:@"Border" and:@"Pulse"];
    }else if ([type isEqual:@"pulse"]){
        selectedIndex=3;
        quickActionHandled = true;
        
        [self updateShortCutItems:@"Transition" and:@"Shake"];
        
    }else if ([type isEqual:@"shake"]){
        selectedIndex=4;
        quickActionHandled = true;
        
        [self updateShortCutItems:@"Border" and:@"Pulse"];
    }else{
        selectedIndex=5;
        quickActionHandled = true;
    
        [self updateShortCutItems:@"Transition" and:@"Pulse"];
    }
    

    if (quickActionHandled) {
        NSIndexPath *ip=[NSIndexPath indexPathForRow:selectedIndex inSection:0];
        [[NSNotificationCenter defaultCenter]postNotificationName:UIApplicationLaunchOptionsShortcutItemKey object:ip userInfo:@{
                                                                                                                                 @"selectedIndexPath":ip
                                                                           
                                                                                                                                 }];

    }else{

        UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"Action aborted" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
        
        
        UIAlertAction *cancelAction = [UIAlertAction
                                       actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel action")
                                       style:UIAlertActionStyleCancel
                                       handler:^(UIAlertAction *action)
                                       {
                                           NSLog(@"Cancel action");
                                       }];
        
        [alertController addAction:cancelAction];
        [self.window.rootViewController presentViewController:alertController animated:YES completion:nil];
    }


    return quickActionHandled;
}


/*creating the mutableShortCutItems and updating it*/
-(void)updateShortCutItems:(NSString *)type1 and:(NSString *)type2{
    
    UIMutableApplicationShortcutItem *aMutableShortcutItem = [self prepareShortcutItemWithIdentifier:type1];
    
    UIMutableApplicationShortcutItem *aMutableShortcutItem2 = [self prepareShortcutItemWithIdentifier:type2];
    
    
    
    
    //setting the UIApplicationShortcutItems with our new Items
    [[UIApplication sharedApplication]setShortcutItems:@[aMutableShortcutItem,aMutableShortcutItem2]];
}

-(UIMutableApplicationShortcutItem *)prepareShortcutItemWithIdentifier:(NSString *)itemIdentifier{
    
    NSString *strbundle=[NSBundle mainBundle].bundleIdentifier;//getting bundleIdentifier
    
    //creating a unique identifier For the UIApplicationShortcutItem
    NSString *dynamicItemIdentifier=[NSString stringWithFormat:@"%@.%@",strbundle,itemIdentifier.lowercaseString];
    //creating title for the UIApplicationShortcutItem
    NSString *dynamicItemTitle=[NSString stringWithFormat:@"%@ Anmation",itemIdentifier];
    
    // Construct the UIApplicationShortcutItem.
    UIMutableApplicationShortcutItem *mutableShortcutItem = [[UIMutableApplicationShortcutItem alloc] initWithType:dynamicItemIdentifier localizedTitle:dynamicItemTitle];
    [mutableShortcutItem setLocalizedSubtitle:@"Show Animation"];
    
    return mutableShortcutItem;
}

@end


