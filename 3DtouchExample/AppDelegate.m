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
@interface AppDelegate () <UISplitViewControllerDelegate,PHLivePhotoViewDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    
    
    UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
    MasterViewController *master=navigationController.viewControllers[0];

    [[NSNotificationCenter defaultCenter] addObserver:master selector:@selector(showAnimation:) name:UIApplicationLaunchOptionsShortcutItemKey object:nil];
    
    BOOL isLaunchedFromQuickAction = false;
    
    
    
    UIApplicationShortcutItem *shortcutItem=launchOptions[UIApplicationLaunchOptionsShortcutItemKey];
    // Check if it's launched from Quick Action
    
    if (shortcutItem){
        
        isLaunchedFromQuickAction = true;
        // Handle the sortcutItem
        [self handleQuickAction:shortcutItem];
    }
    else{
        
    }
    
    NSArray <UIApplicationShortcutItem*> *existingShortcutItems=application.shortcutItems;
    if (!existingShortcutItems.count) {
        
        NSString *strbundle=[NSBundle mainBundle].bundleIdentifier;
        NSString *dynamicItemIdentifier=[NSString stringWithFormat:@"%@.transition",strbundle];
        
        // Construct the items.
        UIMutableApplicationShortcutItem *aMutableShortcutItem = [[UIMutableApplicationShortcutItem alloc] initWithType:dynamicItemIdentifier localizedTitle:@"Transition Animation"];
        [aMutableShortcutItem setLocalizedSubtitle:@"Show Animation"];
        
        
        NSString *dynamicItemIdentifier2=[NSString stringWithFormat:@"%@.pulse",strbundle];
        
        // Construct the items.
        UIMutableApplicationShortcutItem *aMutableShortcutItem2 = [[UIMutableApplicationShortcutItem alloc] initWithType:dynamicItemIdentifier2 localizedTitle:@"Pulse Animation"];
        [aMutableShortcutItem2 setLocalizedSubtitle:@"Show Animation"];
        [[UIApplication sharedApplication]setShortcutItems:@[aMutableShortcutItem,aMutableShortcutItem2]];
    }


    // Return false if the app was launched from a shortcut, so performAction... will not be called.
    return !isLaunchedFromQuickAction;

    
    
    

}

/*
<dict>
<key>UIApplicationShortcutItemIconFile</key>
<string></string>
<key>UIApplicationShortcutItemSubtitle</key>
<string>show Animation</string>
<key>UIApplicationShortcutItemTitle</key>
<string>Transition Animation</string>
<key>UIApplicationShortcutItemType</key>
<string>$(PRODUCT_BUNDLE_IDENTIFIER).transition</string>
</dict>
<dict>
<key>UIApplicationShortcutItemIconFile</key>
<string></string>
<key>UIApplicationShortcutItemSubtitle</key>
<string>show Animation</string>
<key>UIApplicationShortcutItemTitle</key>
<string>Pulse Animation</string>
<key>UIApplicationShortcutItemType</key>
<string>$(PRODUCT_BUNDLE_IDENTIFIER).pulse</string>
</dict>
<dict>
<key>UIApplicationShortcutItemIconFile</key>
<string></string>
<key>UIApplicationShortcutItemSubtitle</key>
<string>show Animation</string>
<key>UIApplicationShortcutItemTitle</key>
<string>Shake Animation</string>
<key>UIApplicationShortcutItemType</key>
<string>$(PRODUCT_BUNDLE_IDENTIFIER).shake</string>
</dict>
<dict>
<key>UIApplicationShortcutItemIconFile</key>
<string></string>
<key>UIApplicationShortcutItemSubtitle</key>
<string>show Animation</string>
<key>UIApplicationShortcutItemTitle</key>
<string>Border Animation</string>
<key>UIApplicationShortcutItemType</key>
<string>$(PRODUCT_BUNDLE_IDENTIFIER).border</string>
</dict>
*/
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
        
        NSString *strbundle=[NSBundle mainBundle].bundleIdentifier;
        NSString *dynamicItemIdentifier=[NSString stringWithFormat:@"%@.border",strbundle];
        
        // Construct the items.
        UIMutableApplicationShortcutItem *aMutableShortcutItem = [[UIMutableApplicationShortcutItem alloc] initWithType:dynamicItemIdentifier localizedTitle:@"Border Animation"];
        [aMutableShortcutItem setLocalizedSubtitle:@"Show Animation"];
        
        
        NSString *dynamicItemIdentifier2=[NSString stringWithFormat:@"%@.pulse",strbundle];
        
        // Construct the items.
        UIMutableApplicationShortcutItem *aMutableShortcutItem2 = [[UIMutableApplicationShortcutItem alloc] initWithType:dynamicItemIdentifier2 localizedTitle:@"Pulse Animation"];
        [aMutableShortcutItem2 setLocalizedSubtitle:@"Show Animation"];
        [[UIApplication sharedApplication]setShortcutItems:@[aMutableShortcutItem,aMutableShortcutItem2]];
    }else if ([type isEqual:@"pulse"]){
        selectedIndex=3;
        quickActionHandled = true;
        
        
        NSString *strbundle=[NSBundle mainBundle].bundleIdentifier;
        NSString *dynamicItemIdentifier=[NSString stringWithFormat:@"%@.transition",strbundle];
        
        // Construct the items.
        UIMutableApplicationShortcutItem *aMutableShortcutItem = [[UIMutableApplicationShortcutItem alloc] initWithType:dynamicItemIdentifier localizedTitle:@"Transition Animation"];
        [aMutableShortcutItem setLocalizedSubtitle:@"Show Animation"];
        
        
        NSString *dynamicItemIdentifier2=[NSString stringWithFormat:@"%@.shake",strbundle];
        
        // Construct the items.
        UIMutableApplicationShortcutItem *aMutableShortcutItem2 = [[UIMutableApplicationShortcutItem alloc] initWithType:dynamicItemIdentifier2 localizedTitle:@"Shake Animation"];
        [aMutableShortcutItem2 setLocalizedSubtitle:@"Show Animation"];
        [[UIApplication sharedApplication]setShortcutItems:@[aMutableShortcutItem,aMutableShortcutItem2]];
        
    }else if ([type isEqual:@"shake"]){
        selectedIndex=4;
        quickActionHandled = true;
        
        
        NSString *strbundle=[NSBundle mainBundle].bundleIdentifier;
        NSString *dynamicItemIdentifier=[NSString stringWithFormat:@"%@.transition",strbundle];
        
        // Construct the items.
        UIMutableApplicationShortcutItem *aMutableShortcutItem = [[UIMutableApplicationShortcutItem alloc] initWithType:dynamicItemIdentifier localizedTitle:@"Transition Animation"];
        [aMutableShortcutItem setLocalizedSubtitle:@"Show Animation"];
        
        
        NSString *dynamicItemIdentifier2=[NSString stringWithFormat:@"%@.pulse",strbundle];
        
        // Construct the items.
        UIMutableApplicationShortcutItem *aMutableShortcutItem2 = [[UIMutableApplicationShortcutItem alloc] initWithType:dynamicItemIdentifier2 localizedTitle:@"Pulse Animation"];
        [aMutableShortcutItem2 setLocalizedSubtitle:@"Show Animation"];
        [[UIApplication sharedApplication]setShortcutItems:@[aMutableShortcutItem,aMutableShortcutItem2]];
    }else{
        selectedIndex=5;
        quickActionHandled = true;
        
        NSString *strbundle=[NSBundle mainBundle].bundleIdentifier;
        NSString *dynamicItemIdentifier=[NSString stringWithFormat:@"%@.transition",strbundle];
        
        // Construct the items.
        UIMutableApplicationShortcutItem *aMutableShortcutItem = [[UIMutableApplicationShortcutItem alloc] initWithType:dynamicItemIdentifier localizedTitle:@"Transition Animation"];
        [aMutableShortcutItem setLocalizedSubtitle:@"Show Animation"];
        
        
        NSString *dynamicItemIdentifier2=[NSString stringWithFormat:@"%@.pulse",strbundle];
        
        // Construct the items.
        UIMutableApplicationShortcutItem *aMutableShortcutItem2 = [[UIMutableApplicationShortcutItem alloc] initWithType:dynamicItemIdentifier2 localizedTitle:@"Pulse Animation"];
        [aMutableShortcutItem2 setLocalizedSubtitle:@"Show Animation"];
        [[UIApplication sharedApplication]setShortcutItems:@[aMutableShortcutItem,aMutableShortcutItem2]];
        
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



#pragma mark - Split view
- (BOOL)splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController {
    if ([secondaryViewController isKindOfClass:[UINavigationController class]] && [[(UINavigationController *)secondaryViewController topViewController] isKindOfClass:[DetailViewController class]] && ([(DetailViewController *)[(UINavigationController *)secondaryViewController topViewController] detailItem] == nil)) {
        // Return YES to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
        return YES;
    } else {
        return NO;
    }
    
    
}
@end


