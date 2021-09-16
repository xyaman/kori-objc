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

        %orig(frame); // TODO: Check if we can remove else

    // Not interested in this view
    } else {
        %orig;
    }
}
%end

//         // We only want to update one CSCoverSheetViewBase
//         let ancestor: UIViewController? = target._viewControllerForAncestor()

//         if(ancestor != nil && ancestor!.isKind(of: CSCombinedListViewController.self)) {
            
//             var newFrame = frame
//             if(!Manager.sharedInstance.isEditing) {
//                 originalFrame = frame
//                 newFrame = frame
//             } else {
//                 newFrame = originalFrame
//             }

//             newFrame.origin.y += Manager.sharedInstance.notificationsYOffset
//             newFrame.origin.x += Manager.sharedInstance.notificationsXOffset
//             newFrame.size.width += Manager.sharedInstance.notificationsWidthOffset
//             newFrame.size.height += Manager.sharedInstance.notificationsHeightOffset
//             orig.setFrame(newFrame)
        
//         } else {
//             orig.setFrame(frame)
//         }
//     }
// }



// CoverSheet hook to get the instance
// class CoverSheetController : ClassHook<CSCoverSheetViewController> {
    
//     func viewDidLoad() {
//         orig.viewDidLoad()
//         Manager.sharedInstance.presenter = target
//     }
    
//     func viewDidDisappear(_ animated: Bool) {
//         orig.viewDidDisappear(animated)
        
//         Manager.sharedInstance.stopEditing()
//     }
// }




// struct Kori : Tweak {
//     init() {
//         CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(),
//             nil,
//             {center, observer, name, object, userInfo in
//                 Manager.sharedInstance.startEditing()
//                 let cover = objc_getClass("SBCoverSheetPresentationManager") as! SBCoverSheetPresentationManager.Type
//                 cover.sharedInstance().setCoverSheetPresented(true, animated: true, withCompletion: nil)
//             },
//             "com.xyaman.koripreferences/StartEditing" as CFString,
//             nil,
//             .coalesce
//         )
//     }
// }