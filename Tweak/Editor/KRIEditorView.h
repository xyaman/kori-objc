#import <UIKit/UIKit.h>

#import "KRIControlsView.h"

@interface KRIEditorView : UIView <UICollectionViewDelegate, UICollectionViewDataSource>
@property(nonatomic, retain) NSLayoutConstraint *topConstraint;

// UI
@property(nonatomic, retain) UIView *blurView;
@property(nonatomic, retain) UIImageView *closeView;
@property(nonatomic, retain) UIImageView *returnView;
@property(nonatomic, retain) UILabel *titleLabel;
@property(nonatomic, retain) UICollectionView *collectionView;
@property(nonatomic, retain) UICollectionViewFlowLayout *collectionLayout;    

// Controls
@property(nonatomic, retain) KRIControlsView *controlsView;
@end

// Blur view
@interface MTMaterialView : UIView
+(UIView *)materialViewWithRecipe:(long long)arg1 configuration:(unsigned long long)arg2 ;
@end