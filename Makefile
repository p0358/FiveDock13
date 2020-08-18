INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk
#TARGET := iphone:clang:13.2:13.0
ARCHS = arm64 arm64e

TWEAK_NAME = FiveDock13
$(TWEAK_NAME)_FILES = FiveDock13.xm
$(TWEAK_NAME)_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

include $(THEOS_MAKE_PATH)/aggregate.mk
