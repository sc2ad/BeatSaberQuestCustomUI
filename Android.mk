# Copyright (C) 2009 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


LOCAL_PATH := $(call my-dir)
TARGET_ARCH_ABI := $(APP_ABI)

include $(CLEAR_VARS)
LOCAL_MODULE := hook

rwildcard=$(wildcard $1$2) $(foreach d,$(wildcard $1*),$(call rwildcard,$d/,$2))

# Build the beatsaber-hook shared library, SPECIFICALLY VERSIONED!
include $(CLEAR_VARS)
LOCAL_MODULE	        := bs-hook
LOCAL_SRC_FILES         := ./extern/libbeatsaber-hook_0_5_8.so
LOCAL_EXPORT_C_INCLUDES := ./extern/beatsaber-hook/shared/
include $(PREBUILT_SHARED_LIBRARY)

include $(CLEAR_VARS)
LOCAL_SHARED_LIBRARIES := bs-hook
LOCAL_LDLIBS           := -llog
LOCAL_CFLAGS           := -DVERSION='"0.2.0"' -isystem 'extern/libil2cpp/il2cpp/libil2cpp' -DID='"CustomUI"' -I'./shared' -I'./extern'
LOCAL_MODULE           := customui
LOCAL_CPPFLAGS         := -std=c++2a
LOCAL_C_INCLUDES       := ./include ./src
LOCAL_SRC_FILES        := $(call rwildcard,src/,*.cpp)
include $(BUILD_SHARED_LIBRARY)
