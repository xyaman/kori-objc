#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, KRISettingType) {
    KRISettingTypeNotification,
};


@interface KRISetting : NSObject
@property(nonatomic, retain) NSString *key;
@property(nonatomic, retain) NSString *name;
@property(nonatomic) KRISettingType type;
@property(nonatomic) CGFloat minValue;
@property(nonatomic) CGFloat maxValue;

+ (instancetype) initWithKey:(NSString *)key name:(NSString *)name type:(KRISettingType)type min:(CGFloat)min max:(CGFloat)max;
@end