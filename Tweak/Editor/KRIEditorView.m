#import "KRIEditorView.h"
#import "KRISettingCell.h"
#import <objc/runtime.h>

#import "../Controller/KRIController.h"

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
    [NSLayoutConstraint activateConstraints:@[
        [self.blurView.widthAnchor constraintEqualToAnchor:self.widthAnchor],
        [self.blurView.heightAnchor constraintEqualToAnchor:self.heightAnchor]
    ]];

    // Title
    self.titleLabel = [UILabel new];
    self.titleLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightBold];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    self.titleLabel.text = @"Editor";

    [self addSubview:self.titleLabel];
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.titleLabel.topAnchor constraintEqualToAnchor:self.topAnchor constant:8],
        [self.titleLabel.widthAnchor constraintEqualToAnchor:self.widthAnchor constant:-60],
        [self.titleLabel.heightAnchor constraintEqualToConstant:30],
        [self.titleLabel.centerXAnchor constraintEqualToAnchor:self.centerXAnchor]
    ]];

    // close View
    self.closeView = [UIImageView new];
    self.closeView.image = [UIImage systemImageNamed:@"xmark"];
    self.closeView.tintColor = [UIColor labelColor];
    self.closeView.contentMode = UIViewContentModeScaleAspectFit;
    self.closeView.userInteractionEnabled = YES;

    [self addSubview:self.closeView];
    self.closeView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.closeView.topAnchor constraintEqualToAnchor:self.topAnchor constant:8],
        [self.closeView.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:-8],
        [self.closeView.widthAnchor constraintEqualToConstant:20],
        [self.closeView.heightAnchor constraintEqualToConstant:20],
    ]];

    // return View
    self.returnView = [UIImageView new];
    self.returnView.hidden = YES;
    self.returnView.image = [UIImage systemImageNamed:@"arrow.uturn.backward"];
    self.returnView.tintColor = [UIColor labelColor];
    self.returnView.contentMode = UIViewContentModeScaleAspectFit;
    self.returnView.userInteractionEnabled = YES;

    [self addSubview:self.returnView];
    self.returnView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.returnView.topAnchor constraintEqualToAnchor:self.topAnchor constant:8],
        [self.returnView.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:-8],
        [self.returnView.widthAnchor constraintEqualToConstant:20],
        [self.returnView.heightAnchor constraintEqualToConstant:20],
    ]];
    
    // Collection Layout
    self.collectionLayout = [UICollectionViewFlowLayout new];
    self.collectionLayout.itemSize = CGSizeMake(70, 70);
    self.collectionLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;

    // Collection View
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.collectionLayout];
    [self.collectionView registerClass:[KRISettingCell class] forCellWithReuseIdentifier:@"SettingCell"];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor clearColor];

    [self addSubview:self.collectionView];
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.collectionView.topAnchor constraintEqualToAnchor:self.topAnchor constant:45],
        [self.collectionView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-8],
        [self.collectionView.widthAnchor constraintEqualToAnchor:self.widthAnchor constant:-20],
        [self.collectionView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor]
    ]];

    // Controls View
    self.controlsView = [[KRIControlsView alloc] init];
    self.controlsView.hidden = YES;
    
    [self addSubview:self.controlsView];
    self.controlsView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.controlsView.topAnchor constraintEqualToAnchor:self.topAnchor constant:45],
        [self.controlsView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-8],
        [self.controlsView.widthAnchor constraintEqualToAnchor:self.widthAnchor constant:-20],
        [self.controlsView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor]
    ]];

    // Gestures

    // Close tap
    UITapGestureRecognizer *closeTap = [[UITapGestureRecognizer alloc] initWithTarget:[KRIController sharedInstance] action:@selector(stopEditor)];
    [self.closeView addGestureRecognizer:closeTap];

    // Return tap
    UITapGestureRecognizer *returnTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toggleControlsView)];
    [self.returnView addGestureRecognizer:returnTap];

    // Movement pan
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [self addGestureRecognizer:pan];

    return self;
}

- (void) toggleControlsView {
    self.collectionView.hidden = !self.collectionView.hidden;
    self.controlsView.hidden = !self.controlsView.hidden;

    self.closeView.hidden = !self.closeView.hidden;
    self.returnView.hidden = !self.returnView.hidden;

    if(!self.collectionView.hidden) {
        self.titleLabel.text = @"Editor";
    }
}

- (void) handlePan:(UIPanGestureRecognizer *)gesture {
    CGFloat posY = [gesture locationInView:self.superview].y;
    CGFloat maxY = UIScreen.mainScreen.bounds.size.height - self.frame.size.height;

    [UIView animateWithDuration:0.2 animations:^{
        self.topConstraint.constant = posY > maxY ? maxY : posY;
        [self.superview layoutIfNeeded];
    }];
}

// Source delegate methods
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)numberOfItemsInSection {
    return [KRIController sharedInstance].editableSettings.count;
}

- (KRISettingCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    KRISettingCell *cell = (KRISettingCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"SettingCell" forIndexPath:indexPath];
    KRISetting *setting = [KRIController sharedInstance].editableSettings[indexPath.row];

    cell.label.text = setting.name;
    cell.iconView.image = [[KRIController sharedInstance] getSettingIcon:setting];
    cell.iconView.tintColor = [UIColor labelColor];

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    KRISetting *setting = [KRIController sharedInstance].editableSettings[indexPath.row];

    [self toggleControlsView];
    self.titleLabel.text = setting.name;
    [self.controlsView startEditWithSetting:setting];
}
@end