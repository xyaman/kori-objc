TWEAK_NAME = Kori

$(TWEAK_NAME)_FILES = $(shell find . -name "*.m") $(shell find . -name "*.x")
$(TWEAK_NAME)_CFLAGS = -DTHEOS_LEAN_AND_MEAN -fobjc-arc
$(TWEAK_NAME)_FRAMEWORKS = UIKit CoverSheet
$(TWEAK_NAME)_EXTRA_FRAMEWORKS = Cephei


include $(THEOS)/makefiles/common.mk
include $(THEOS_MAKE_PATH)/tweak.mk