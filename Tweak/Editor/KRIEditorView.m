#import "KRIEditorView.h"
#import "objc/runtime.h"

@interface KRIEditorView ()
@end

@implementation KRIEditorView
- (instancetype) init {
    self = [super init];

    // View settings
    self.backgroundColor = [UIColor clearColor]; // Because we will use a blur view
    self.clipsToBounds = YES;
    self.layer.cornerRadius = 13;
    self.layer.cornerCurve = kCACornerCurveContinuous;

    // Blur view
    self.blurView = [objc_getClass("MTMaterialView") materialViewWithRecipe:1 configuration:1];
    [self addSubview:self.blurView];

    self.blurView.translatesAutoresizingMaskIntoConstraints = NO;
    // TODO: Change test use width and height anchor
    [self.blurView.widthAnchor constraintEqualToAnchor:self.widthAnchor].active = YES;
    [self.blurView.heightAnchor constraintEqualToAnchor:self.heightAnchor].active = YES;

    //         blurView.topAnchor.constraint(equalTo: topAnchor).isActive = true
    //         blurView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    //         blurView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
    //         blurView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true

    return self;
}
@end