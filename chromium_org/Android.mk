# Copyright (c) 2012 The Chromium Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

# This Android makefile is used to build WebView in the Android build system.
# gyp autogenerates most of the real makefiles, which we just include here if
# we are doing a WebView build. For other builds, this makefile does nothing,
# which prevents the Android build system from mistakenly loading any other
# Android.mk that may exist in the Chromium tree.

CHROMIUM_DIR := $(call my-dir)

# Assume that if the gyp autogenerated makefile exists, we are doing the
# WebView build using the Android build system.
ifneq (,$(wildcard $(CHROMIUM_DIR)/GypAndroid.$(HOST_OS)-$(TARGET_ARCH).mk))

# Don't include anything if the product is using a prebuilt webviewchromium.
ifneq ($(PRODUCT_PREBUILT_WEBVIEWCHROMIUM),yes)

# We default to release for the Android build system. Developers working on
# WebView code can build with "make GYP_CONFIGURATION=Debug".
GYP_CONFIGURATION := Release

include $(CHROMIUM_DIR)/GypAndroid.$(HOST_OS)-$(TARGET_ARCH).mk
include $(CHROMIUM_DIR)/android_webview/Android.mk

endif
endif

# Workaround for broken texture is to prevent binding external OES (for tegra2)
ifeq ($(BOARD_HAS_BROKEN_GL_TEXTURE),true)
    LOCAL_CFLAGS += -DPREVENT_BINDING_EXTERNAL_OES
endif
