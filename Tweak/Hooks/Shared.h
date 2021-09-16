#import <UIKit/UIKit.h>

@interface UIView (Kori)
- (nullable UIViewController *) _viewControllerForAncestor;
@end

// Main LS View Controller
@interface CSCoverSheetViewController : UIViewController
@end

// Notifications Controller view
@interface CSCoverSheetViewBase : UIView
@property(nonatomic) CGRect originalFrame;
@end

// Notifications Controller
@interface CSCombinedListViewController : UIViewController
@end

@interface SBCoverSheetPresentationManager : NSObject
+(nonnull SBCoverSheetPresentationManager *) sharedInstance;
-(void)setCoverSheetPresented:(BOOL)arg1 animated:(BOOL)arg2 withCompletion:(nullable id)arg3 ;
@end
