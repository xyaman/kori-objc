#import "Shared.h"
#import "objc/runtime.h"
#import "../Controller/KRIController.h"

void startEdit() {
    [[KRIController sharedInstance] startEditor];

    // Open notification center
    [[objc_getClass("SBCoverSheetPresentationManager") sharedInstance] setCoverSheetPresented:YES animated:YES withCompletion:nil];
}

%hook CSCoverSheetViewController
- (void) viewDidLoad {
    %orig;

    [KRIController sharedInstance].presenterView = self.view;
}

- (void) viewDidDisappear:(BOOL)animated {
    %orig;

    [[KRIController sharedInstance] stopEditor];
}
%end

%ctor {
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)startEdit, (CFStringRef)@"com.xyaman.koripreferences/StartEdit", NULL, (CFNotificationSuspensionBehavior)kNilOptions);
}