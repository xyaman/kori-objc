#import "KRISetting.h"

@interface KRISetting ()
@end

@implementation KRISetting
+ (instancetype) initWithKey:(NSString *)key name:(NSString *)name type:(KRISettingType)type min:(CGFloat)min max:(CGFloat)max {
    KRISetting *setting = [[self alloc] init];

    setting.key = key;
    setting.name = name;
    setting.type = type;
    setting.minValue = min;
    setting.maxValue = max;

    return setting;
}
@end