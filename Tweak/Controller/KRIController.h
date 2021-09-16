#import <UIKit/UIKit.h>
#import <Cephei/HBPreferences.h>

#import "KRISetting.h"

@interface KRIController : NSObject
// Preferences
@property(nonatomic, retain) HBPreferences *preferences;

// Editable preferences (not available on tweak prefs)
@property(nonatomic, retain) NSMutableArray<KRISetting *> *editableSettings;

// Notifications
@property(nonatomic) CGFloat notificationsXOffset;
@property(nonatomic) CGFloat notificationsYOffset;
@property(nonatomic) CGFloat notificationsWidthOffset;
@property(nonatomic) CGFloat notificationsHeightOffset;

// Hooked views
@property(nonatomic, retain) UIView *presenterView;
@property(nonatomic, retain) UIView *notificationsView;


// Edition
@property(nonatomic) BOOL isEditing;

+ (instancetype) sharedInstance;

// Edit methods
- (void) editSetting:(KRISetting *)setting newValue:(CGFloat)value;
@end