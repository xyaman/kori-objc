#import "Shared.h"
#import "../Controller/KRIController.h"

%group NotificationsHistory
%hook NCNotificationListView

- (void)setRevealed:(BOOL)arg1 {
    %orig(YES);
}

- (BOOL) revealed {
    return YES;
}
%end

// History notifications
%hook NCNotificationListSectionHeaderView
- (void) didMoveToWindow {
    self.hidden = YES;
}
- (CGRect) frame {
    return CGRectMake(0, 0, 0, 0);
}
- (BOOL) hidden {
    return YES;
}
%end

// Hide older notifications
%hook NCNotificationListSectionRevealHintView
- (void) didMoveToWindow {
    self.hidden = YES;
}

- (CGRect) frame {
    return CGRectMake(0, 0, 0, 0);
}

- (BOOL) hidden {
    return YES;
}
%end

// Hide controls on stack notifications
%hook NCNotificationListCoalescingHeaderCell
- (void) didMoveToWindow {
    self.hidden = YES;
}

- (CGRect) frame {
    return CGRectMake(0, 0, 0, 0);
}

- (BOOL) hidden {
    return YES;
}
%end

// Hide controls on stack notifications
%hook NCNotificationListCoalescingControlsCell
- (void) didMoveToWindow {
    self.hidden = YES;
}

- (CGRect) frame {
    return CGRectMake(0, 0, 0, 0);
}

- (BOOL) hidden {
    return YES;
}
%end
%end


%ctor {
    if([KRIController sharedInstance].disableNotificationsHistory) %init(NotificationsHistory);
}