/*
 * Copyright (C) 2018-2024 The TeamWin Recovery Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include <string>

#include "property_service.h"

namespace android {
namespace init {

void vendor_load_properties()
{
    // SC-02G / kltedcmactive (Samsung Galaxy S5 Active NTT Docomo)
    property_set("ro.product.model", "SC-02G");
    property_set("ro.product.device", "kltedcmactive");
    property_set("ro.product.name", "kltedcmactive");
    property_set("ro.build.product", "kltedcmactive");
    property_set("ro.ril.enable.dcm.feature", "1");
}

}  // namespace init
}  // namespace android
