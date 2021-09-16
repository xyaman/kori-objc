#import "Shared.h"
#import "../Controller/KRIController.h"

// Notifications Scroll view hook
%hook CSCoverSheetViewBase
%property (nonatomic) CGRect originalFrame;

- (void) didMoveToWindow {
    %orig;

    // The view we need is a view of CSCombinedListViewController
    UIViewController *ancestor = [self _viewControllerForAncestor];
    if(ancestor != nil && [ancestor isKindOfClass: CSCombinedListViewController.self]) {
        [KRIController sharedInstance].notificationsView = self;
    }
}

- (void) setFrame:(CGRect)frame {
    
    // The view we need is a view of CSCombinedListViewController
    UIViewController *ancestor = [self _viewControllerForAncestor];
    if(ancestor != nil && [ancestor isKindOfClass: CSCombinedListViewController.self]) {

        if([KRIController sharedInstance].isEditing) {
            frame = self.originalFrame;
        }

        self.originalFrame = frame;

        frame.origin.x += [KRIController sharedInstance].notificationsXOffset;
        frame.origin.y += [KRIController sharedInstance].notificationsYOffset;
        frame.size.width += [KRIController sharedInstance].notificationsWidthOffset;
        // frame.size.height += [KRIController sharedInstance].notificationsHeightOffset;

        %orig(frame); // TODO: Check if we can remove the else

    // Not interested in this view
    } else {
        %orig;
    }
}
%end