#import "KRIControlsView.h"
#import "../Controller/KRIController.h"

@interface KRIControlsView ()
@end

@implementation KRIControlsView
- (instancetype) init {
    self = [super init];

    // View settings
    self.backgroundColor = [UIColor clearColor];

    // Slider
    self.slider = [UISlider new];
    [self.slider addTarget:self action:@selector(sliderDidBegin:) forControlEvents:UIControlEventTouchDown];
    [self.slider addTarget:self action:@selector(sliderDidChange:) forControlEvents:UIControlEventValueChanged];

    [self addSubview:self.slider];
    self.slider.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.slider.widthAnchor constraintEqualToAnchor:self.widthAnchor constant:-140],
        [self.slider.heightAnchor constraintEqualToAnchor:self.heightAnchor constant:-15],
        [self.slider.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-15],
        [self.slider.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
    ]];

    // Min label
    self.minLabel = [UILabel new];
    self.minLabel.font = [UIFont systemFontOfSize:12];

    [self addSubview:self.minLabel];
    self.minLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.minLabel.widthAnchor constraintEqualToConstant:50],
        [self.minLabel.heightAnchor constraintEqualToAnchor:self.heightAnchor constant:-15],
        [self.minLabel.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:15],
        [self.minLabel.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-15],
    ]]; 

    // Max label
    self.maxLabel = [UILabel new];
    self.maxLabel.font = [UIFont systemFontOfSize:12];

    [self addSubview:self.maxLabel];
    self.maxLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.maxLabel.widthAnchor constraintEqualToConstant:50],
        [self.maxLabel.heightAnchor constraintEqualToAnchor:self.heightAnchor constant:-15],
        [self.maxLabel.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:-15],
        [self.maxLabel.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-15],
    ]]; 

    // Current text field
    self.currentTextField = [UITextField new];
    self.currentTextField.textAlignment = NSTextAlignmentCenter;
    self.currentTextField.keyboardType = UIKeyboardTypeDecimalPad;
    
    [self addSubview:self.currentTextField];
    self.currentTextField.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.currentTextField.widthAnchor constraintEqualToAnchor:self.widthAnchor],
        [self.currentTextField.topAnchor constraintEqualToAnchor:self.slider.bottomAnchor constant:2],
        [self.currentTextField.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
        [self.currentTextField.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
    ]];

    return self;
}

- (void) startEditWithSetting:(KRISetting *)setting {
    self.currentSetting = setting;
    self.currentValue = [[KRIController sharedInstance] getValueOfSetting:setting];

    self.currentTextField.text = [NSString stringWithFormat:@"%.2f", self.currentValue];
    self.slider.minimumValue = setting.minValue;
    self.slider.maximumValue = setting.maxValue;

    [self.slider setValue:self.currentValue animated:YES];

    self.minLabel.text = [NSString stringWithFormat:@"%.2f", setting.minValue];
    self.maxLabel.text = [NSString stringWithFormat:@"%.2f", setting.maxValue];
}

- (void) sliderDidBegin:(UISlider *)slider {
}

- (void) sliderDidChange:(UISlider *)slider {
    self.currentValue = slider.value;
    self.currentTextField.text = [NSString stringWithFormat:@"%.2f", self.currentValue];
    [[KRIController sharedInstance] editSetting:self.currentSetting newValue:self.currentValue];
}
@end