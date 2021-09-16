#import "KRIController.h"

@interface KRIController ()
@end

@implementation KRIController
+ (instancetype) sharedInstance {
    static KRIController *controller = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        controller = [[KRIController alloc] init];
    });
    return controller;    
}

- (instancetype) init {
    self = [super init];

    self.editorView = [[KRIEditorView alloc] init];

    // Load preferences and add observers
    self.preferences = [[HBPreferences alloc] initWithIdentifier:@"com.xyaman.koripreferences"];
    [self.preferences registerFloat:&_notificationsXOffset default:0 forKey:@"notificationsXOffset"];
    [self.preferences registerFloat:&_notificationsYOffset default:0 forKey:@"notificationsYOffset"];
    [self.preferences registerFloat:&_notificationsWidthOffset default:0 forKey:@"notificationsWidthOffset"];
    [self.preferences registerFloat:&_notificationsHeightOffset default:0 forKey:@"notificationsHeightOffset"];

    self.editableSettings = [NSMutableArray new];

    // Notification editable settings
    [self.editableSettings addObjectsFromArray:@[
        [KRISetting initWithKey:@"notificationsXOffset" name:@"Notifications X Offset" type:KRISettingTypeNotification min:-300 max:300],
        [KRISetting initWithKey:@"notificationsYOffset" name:@"Notifications Y Offset" type:KRISettingTypeNotification min:-300 max:300],
        [KRISetting initWithKey:@"notificationsWidthOffset" name:@"Notifications Width Offset" type:KRISettingTypeNotification min:-300 max:300],
        [KRISetting initWithKey:@"notificationsHeightOffset" name:@"Notifications Height Offset" type:KRISettingTypeNotification min:-300 max:300]
    ]];

    return self;
}

- (void) startEditor {
    if(self.isEditing || !self.presenterView) return;
    self.isEditing = YES;

    // Add our view to the presenter view
    [self.presenterView addSubview:self.editorView];
    self.editorView.translatesAutoresizingMaskIntoConstraints = NO;

    self.editorView.topConstraint = [self.editorView.topAnchor constraintEqualToAnchor:self.presenterView.topAnchor constant:0];

    [NSLayoutConstraint activateConstraints:@[
        self.editorView.topConstraint,
        [self.editorView.heightAnchor constraintEqualToConstant:150],
        [self.editorView.centerXAnchor constraintEqualToAnchor:self.presenterView.centerXAnchor],
        [self.editorView.widthAnchor constraintEqualToAnchor:self.presenterView.widthAnchor constant:-20]
    ]];
}

- (void) stopEditor {
    if(!self.isEditing) return;
    self.isEditing = NO;

    [self.editorView removeFromSuperview];
}

- (void) editSetting:(KRISetting *)setting newValue:(CGFloat)value {
    // Update the value on our preferences bundle
    [self.preferences setFloat:value forKey:setting.key];

    // Update on real-time our hooked views
    switch(setting.type) {
        case KRISettingTypeNotification:
            // This forces to update the frame
            [KRIController sharedInstance].notificationsView.frame = CGRectZero;
    }
}
@end