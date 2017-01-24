#Android makefile to build kernel as a part of Android Build
PERL		= perl

ifeq ($(TARGET_PREBUILT_KERNEL),)

LOCAL_PRIVATE_PATH := device/htc/a51dtul/kernel
LOCAL_MODULES_PATH := device/htc/a51dtul/kernel/modules
KERNEL_MODULES_OUT := $(TARGET_OUT)/lib/modules

TARGET_KERNEL_ARCH := $(strip $(TARGET_KERNEL_ARCH))
ifeq ($(TARGET_KERNEL_ARCH),)
KERNEL_ARCH := arm64
else
KERNEL_ARCH := $(TARGET_KERNEL_ARCH)
endif

KERNEL_OUT := $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ
KERNEL_CONFIG := $(LOCAL_PRIVATE_PATH)/user/.config
KERNEL_HEADERS_INSTALL := $(KERNEL_OUT)/usr
KERNEL_MODULES_INSTALL := system
KERNEL_IMG=$(KERNEL_OUT)/arch/$(KERNEL_ARCH)/boot/Image

ifeq ($(TARGET_USES_UNCOMPRESSED_KERNEL),true)
$(info Using uncompressed kernel)
TARGET_PREBUILT_INT_KERNEL := $(KERNEL_OUT)/arch/$(KERNEL_ARCH)/boot/Image
else
TARGET_PREBUILT_INT_KERNEL := $(KERNEL_OUT)/arch/$(KERNEL_ARCH)/boot/zImage
endif

define append-dtb
cp $(LOCAL_PRIVATE_PATH)/dt.img $(OUT)/dt.img
endef

TARGET_PREBUILT_KERNEL := $(TARGET_PREBUILT_INT_KERNEL)

$(KERNEL_OUT):
	mkdir -p $(KERNEL_OUT)

$(TARGET_PREBUILT_INT_KERNEL): $(KERNEL_OUT) $(KERNEL_HEADERS_INSTALL)
	$(append-dtb)

$(KERNEL_HEADERS_INSTALL): $(KERNEL_OUT)
	cp -r $(LOCAL_PRIVATE_PATH)/user/* $(KERNEL_OUT)/

# Create a link for the wlan modules
$(shell mkdir -p $(TARGET_OUT)/lib/modules/pronto; \
        ln -sf /system/lib/modules/pronto/pronto_wlan.ko \
               $(TARGET_OUT)/lib/modules/wlan.ko)

# copy  wlan and fmradio modules
$(shell cp $(LOCAL_MODULES_PATH)/radio-iris-transport.ko $(KERNEL_MODULES_OUT)/radio-iris-transport.ko)
$(shell cp $(LOCAL_MODULES_PATH)/moc_crypto.ko.sig.3.10 $(KERNEL_MODULES_OUT)/moc_crypto.ko.sig.3.10)
$(shell cp $(LOCAL_MODULES_PATH)/ansi_cprng.ko $(KERNEL_MODULES_OUT)/ansi_cprng.ko)
$(shell cp $(LOCAL_MODULES_PATH)/crypto_test_mod.ko $(KERNEL_MODULES_OUT)/crypto_test_mod.ko)
$(shell cp $(LOCAL_MODULES_PATH)/dm-crypt.ko $(KERNEL_MODULES_OUT)/dm-crypt.ko)
$(shell cp $(LOCAL_MODULES_PATH)/ecryptfs.ko $(KERNEL_MODULES_OUT)/ecryptfs.ko)
$(shell cp $(LOCAL_MODULES_PATH)/evbug.ko $(KERNEL_MODULES_OUT)/evbug.ko)
$(shell cp $(LOCAL_MODULES_PATH)/gspca_main.ko $(KERNEL_MODULES_OUT)/gspca_main.ko)
$(shell cp $(LOCAL_MODULES_PATH)/mmc_test.ko $(KERNEL_MODULES_OUT)/mmc_test.ko)
$(shell cp $(LOCAL_MODULES_PATH)/moc_crypto.ko $(KERNEL_MODULES_OUT)/moc_crypto.ko)
$(shell cp $(LOCAL_MODULES_PATH)/moc_crypto_api_tmpl.ko $(KERNEL_MODULES_OUT)/moc_crypto_api_tmpl.ko)
$(shell cp $(LOCAL_MODULES_PATH)/moc_platform_mod.ko $(KERNEL_MODULES_OUT)/moc_platform_mod.ko)
$(shell cp $(LOCAL_MODULES_PATH)/radio-iris-transport.ko $(KERNEL_MODULES_OUT)/radio-iris-transport.ko)
$(shell cp $(LOCAL_MODULES_PATH)/spidev.ko $(KERNEL_MODULES_OUT)/spidev.ko)
$(shell cp $(LOCAL_MODULES_PATH)/pronto/pronto_wlan.ko $(KERNEL_MODULES_OUT)/pronto/pronto_wlan.ko)

endif

