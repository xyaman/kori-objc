#import <UIKit/UIKit.h>

#import "../Controller/KRISetting.h"

@interface KRIControlsView : UIView
// Data
@property(nonatomic, retain) KRISetting *currentSetting;
@property(nonatomic) CGFloat currentValue;
    
// UI
@property(nonatomic, retain) UISlider *slider;
@property(nonatomic, retain) UILabel *minLabel;
@property(nonatomic, retain) UILabel *maxLabel;
@property(nonatomic, retain) UITextField *currentTextField;

- (void) startEditWithSetting:(KRISetting *)setting;
@end