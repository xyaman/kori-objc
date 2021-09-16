#import "KRISettingCell.h"

@interface KRISettingCell ()
@end

@implementation KRISettingCell
- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];

    self.label = [UILabel new];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.font = [UIFont systemFontOfSize:12];
    self.label.adjustsFontSizeToFitWidth = YES;
    self.label.numberOfLines = 2;
    // self.label.minimumFontSize = 6;

    [self.contentView addSubview:self.label];
    self.label.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.label.widthAnchor constraintEqualToAnchor:self.contentView.widthAnchor],
        [self.label.heightAnchor constraintEqualToConstant:15],
        [self.label.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor],
        [self.label.centerXAnchor constraintEqualToAnchor:self.contentView.centerXAnchor],
    ]];


    self.iconView = [UIImageView new];
    self.iconView.contentMode = UIViewContentModeScaleAspectFit;
    
    [self.contentView addSubview:self.iconView];
    self.iconView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.iconView.widthAnchor constraintEqualToConstant:45],
        [self.iconView.heightAnchor constraintEqualToConstant:45],
        [self.iconView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor],
        [self.iconView.centerXAnchor constraintEqualToAnchor:self.contentView.centerXAnchor],
    ]];

    return self;
}

- (void) prepareForReuse {
    [super prepareForReuse];

    self.label.text = nil;
    self.iconView.image = nil;
    self.iconView.tintColor = [UIColor labelColor];
}
@end