# Release name
PRODUCT_RELEASE_NAME := a51dtul

LOCAL_PATH := device/htc/a51dtul

# Boot animation
TARGET_SCREEN_HEIGHT := 1280
TARGET_SCREEN_WIDTH := 720

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)

# Inherit some common CM stuff.
$(call inherit-product, vendor/cm/config/common_full_phone.mk)
#$(call inherit-product, vendor/cm/config/nfc_enhanced.mk)

$(call inherit-product, device/htc/a51dtul/device.mk)

BOARD_VENDOR := htc
BOARD_NUMBER_OF_CAMERAS := 4

BOARD_HARDWARE_CLASS := \
    $(LOCAL_PATH)/cmhw

# Device naming
PRODUCT_NAME := cm_a51dtul
PRODUCT_DEVICE := a51dtul
PRODUCT_BRAND := htc
PRODUCT_MANUFACTURER := HTC
PRODUCT_MODEL := HTC Desire 820u
