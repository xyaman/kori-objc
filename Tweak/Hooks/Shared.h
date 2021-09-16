#import <UIKit/UIKit.h>

@interface UIView (Kori)
- (UIViewController *) _viewControllerForAncestor;
@end

@interface CSCoverSheetViewBase : UIView
@property(nonatomic) CGRect originalFrame;
@end

@interface CSCombinedListViewController : UIViewController
@end