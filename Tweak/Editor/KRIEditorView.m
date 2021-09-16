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


    // Gestures
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [self addGestureRecognizer:pan];

    return self;
}

- (void) handlePan:(UIPanGestureRecognizer *)gesture {
    CGFloat posY = [gesture locationInView:self.superview].y;
    CGFloat maxY = UIScreen.mainScreen.bounds.size.height - self.frame.size.height;

    [UIView animateWithDuration:0.2 animations:^{
        self.topConstraint.constant = posY > maxY ? maxY : posY;
        [self.superview layoutIfNeeded];
    }];
}
@end