# 3DtouchExample


/*	adding the static ShortcutItems using Plist./*/

/*	these will be shown even the app is not launched once after downloading.	/*/

/*	copy this code to your plist and run.	/*/

```xml

<key>UIApplicationShortcutItems</key>
<array>
<dict>
<key>UIApplicationShortcutItemIconFile</key>
<string></string>
<key>UIApplicationShortcutItemSubtitle</key>
<string>show Animation</string>
<key>UIApplicationShortcutItemTitle</key>
<string>Simple Animation</string>
<key>UIApplicationShortcutItemType</key>
<string>$(PRODUCT_BUNDLE_IDENTIFIER).simple</string>
</dict>
<dict>
<key>UIApplicationShortcutItemIconFile</key>
<string></string>
<key>UIApplicationShortcutItemSubtitle</key>
<string>show Animation</string>
<key>UIApplicationShortcutItemTitle</key>
<string>Bounce Animation</string>
<key>UIApplicationShortcutItemType</key>
<string>$(PRODUCT_BUNDLE_IDENTIFIER).bounce</string>
</dict>
</array>

```

/*	connect the segue from your cell to the viewController 	*/
/*	add the Identifier to your segue	*/
/*	now check the Peek & Pop.	*/
/*	Preview Identifier will preview the viewController in your UITableView or UICollectionView.*/
/*	CommitIdentifier will commit the viewController in your UITableView or UICollectionView.*/

￼


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
// Override point for customization after application launch.
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
