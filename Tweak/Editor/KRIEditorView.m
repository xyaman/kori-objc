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
@end