// Copyright 2020 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

// Code generated by protoc-gen-go. DO NOT EDIT.
// versions:
// 	protoc-gen-go v1.25.0
// 	protoc        v3.12.3
// source: google/ads/googleads/v4/enums/click_type.proto

package enums

import (
	reflect "reflect"
	sync "sync"

	proto "github.com/golang/protobuf/proto"
	_ "google.golang.org/genproto/googleapis/api/annotations"
	protoreflect "google.golang.org/protobuf/reflect/protoreflect"
	protoimpl "google.golang.org/protobuf/runtime/protoimpl"
)

const (
	// Verify that this generated code is sufficiently up-to-date.
	_ = protoimpl.EnforceVersion(20 - protoimpl.MinVersion)
	// Verify that runtime/protoimpl is sufficiently up-to-date.
	_ = protoimpl.EnforceVersion(protoimpl.MaxVersion - 20)
)

// This is a compile-time assertion that a sufficiently up-to-date version
// of the legacy proto package is being used.
const _ = proto.ProtoPackageIsVersion4

// Enumerates Google Ads click types.
type ClickTypeEnum_ClickType int32

const (
	// Not specified.
	ClickTypeEnum_UNSPECIFIED ClickTypeEnum_ClickType = 0
	// The value is unknown in this version.
	ClickTypeEnum_UNKNOWN ClickTypeEnum_ClickType = 1
	// App engagement ad deep link.
	ClickTypeEnum_APP_DEEPLINK ClickTypeEnum_ClickType = 2
	// Breadcrumbs.
	ClickTypeEnum_BREADCRUMBS ClickTypeEnum_ClickType = 3
	// Broadband Plan.
	ClickTypeEnum_BROADBAND_PLAN ClickTypeEnum_ClickType = 4
	// Manually dialed phone calls.
	ClickTypeEnum_CALL_TRACKING ClickTypeEnum_ClickType = 5
	// Phone calls.
	ClickTypeEnum_CALLS ClickTypeEnum_ClickType = 6
	// Click on engagement ad.
	ClickTypeEnum_CLICK_ON_ENGAGEMENT_AD ClickTypeEnum_ClickType = 7
	// Driving direction.
	ClickTypeEnum_GET_DIRECTIONS ClickTypeEnum_ClickType = 8
	// Get location details.
	ClickTypeEnum_LOCATION_EXPANSION ClickTypeEnum_ClickType = 9
	// Call.
	ClickTypeEnum_LOCATION_FORMAT_CALL ClickTypeEnum_ClickType = 10
	// Directions.
	ClickTypeEnum_LOCATION_FORMAT_DIRECTIONS ClickTypeEnum_ClickType = 11
	// Image(s).
	ClickTypeEnum_LOCATION_FORMAT_IMAGE ClickTypeEnum_ClickType = 12
	// Go to landing page.
	ClickTypeEnum_LOCATION_FORMAT_LANDING_PAGE ClickTypeEnum_ClickType = 13
	// Map.
	ClickTypeEnum_LOCATION_FORMAT_MAP ClickTypeEnum_ClickType = 14
	// Go to store info.
	ClickTypeEnum_LOCATION_FORMAT_STORE_INFO ClickTypeEnum_ClickType = 15
	// Text.
	ClickTypeEnum_LOCATION_FORMAT_TEXT ClickTypeEnum_ClickType = 16
	// Mobile phone calls.
	ClickTypeEnum_MOBILE_CALL_TRACKING ClickTypeEnum_ClickType = 17
	// Print offer.
	ClickTypeEnum_OFFER_PRINTS ClickTypeEnum_ClickType = 18
	// Other.
	ClickTypeEnum_OTHER ClickTypeEnum_ClickType = 19
	// Product plusbox offer.
	ClickTypeEnum_PRODUCT_EXTENSION_CLICKS ClickTypeEnum_ClickType = 20
	// Shopping - Product - Online.
	ClickTypeEnum_PRODUCT_LISTING_AD_CLICKS ClickTypeEnum_ClickType = 21
	// Sitelink.
	ClickTypeEnum_SITELINKS ClickTypeEnum_ClickType = 22
	// Show nearby locations.
	ClickTypeEnum_STORE_LOCATOR ClickTypeEnum_ClickType = 23
	// Headline.
	ClickTypeEnum_URL_CLICKS ClickTypeEnum_ClickType = 25
	// App store.
	ClickTypeEnum_VIDEO_APP_STORE_CLICKS ClickTypeEnum_ClickType = 26
	// Call-to-Action overlay.
	ClickTypeEnum_VIDEO_CALL_TO_ACTION_CLICKS ClickTypeEnum_ClickType = 27
	// Cards.
	ClickTypeEnum_VIDEO_CARD_ACTION_HEADLINE_CLICKS ClickTypeEnum_ClickType = 28
	// End cap.
	ClickTypeEnum_VIDEO_END_CAP_CLICKS ClickTypeEnum_ClickType = 29
	// Website.
	ClickTypeEnum_VIDEO_WEBSITE_CLICKS ClickTypeEnum_ClickType = 30
	// Visual Sitelinks.
	ClickTypeEnum_VISUAL_SITELINKS ClickTypeEnum_ClickType = 31
	// Wireless Plan.
	ClickTypeEnum_WIRELESS_PLAN ClickTypeEnum_ClickType = 32
	// Shopping - Product - Local.
	ClickTypeEnum_PRODUCT_LISTING_AD_LOCAL ClickTypeEnum_ClickType = 33
	// Shopping - Product - MultiChannel Local.
	ClickTypeEnum_PRODUCT_LISTING_AD_MULTICHANNEL_LOCAL ClickTypeEnum_ClickType = 34
	// Shopping - Product - MultiChannel Online.
	ClickTypeEnum_PRODUCT_LISTING_AD_MULTICHANNEL_ONLINE ClickTypeEnum_ClickType = 35
	// Shopping - Product - Coupon.
	ClickTypeEnum_PRODUCT_LISTING_ADS_COUPON ClickTypeEnum_ClickType = 36
	// Shopping - Product - Sell on Google.
	ClickTypeEnum_PRODUCT_LISTING_AD_TRANSACTABLE ClickTypeEnum_ClickType = 37
	// Shopping - Product - App engagement ad deep link.
	ClickTypeEnum_PRODUCT_AD_APP_DEEPLINK ClickTypeEnum_ClickType = 38
	// Shopping - Showcase - Category.
	ClickTypeEnum_SHOWCASE_AD_CATEGORY_LINK ClickTypeEnum_ClickType = 39
	// Shopping - Showcase - Local storefront.
	ClickTypeEnum_SHOWCASE_AD_LOCAL_STOREFRONT_LINK ClickTypeEnum_ClickType = 40
	// Shopping - Showcase - Online product.
	ClickTypeEnum_SHOWCASE_AD_ONLINE_PRODUCT_LINK ClickTypeEnum_ClickType = 42
	// Shopping - Showcase - Local product.
	ClickTypeEnum_SHOWCASE_AD_LOCAL_PRODUCT_LINK ClickTypeEnum_ClickType = 43
	// Promotion Extension.
	ClickTypeEnum_PROMOTION_EXTENSION ClickTypeEnum_ClickType = 44
	// Ad Headline.
	ClickTypeEnum_SWIPEABLE_GALLERY_AD_HEADLINE ClickTypeEnum_ClickType = 45
	// Swipes.
	ClickTypeEnum_SWIPEABLE_GALLERY_AD_SWIPES ClickTypeEnum_ClickType = 46
	// See More.
	ClickTypeEnum_SWIPEABLE_GALLERY_AD_SEE_MORE ClickTypeEnum_ClickType = 47
	// Sitelink 1.
	ClickTypeEnum_SWIPEABLE_GALLERY_AD_SITELINK_ONE ClickTypeEnum_ClickType = 48
	// Sitelink 2.
	ClickTypeEnum_SWIPEABLE_GALLERY_AD_SITELINK_TWO ClickTypeEnum_ClickType = 49
	// Sitelink 3.
	ClickTypeEnum_SWIPEABLE_GALLERY_AD_SITELINK_THREE ClickTypeEnum_ClickType = 50
	// Sitelink 4.
	ClickTypeEnum_SWIPEABLE_GALLERY_AD_SITELINK_FOUR ClickTypeEnum_ClickType = 51
	// Sitelink 5.
	ClickTypeEnum_SWIPEABLE_GALLERY_AD_SITELINK_FIVE ClickTypeEnum_ClickType = 52
	// Hotel price.
	ClickTypeEnum_HOTEL_PRICE ClickTypeEnum_ClickType = 53
	// Price Extension.
	ClickTypeEnum_PRICE_EXTENSION ClickTypeEnum_ClickType = 54
	// Book on Google hotel room selection.
	ClickTypeEnum_HOTEL_BOOK_ON_GOOGLE_ROOM_SELECTION ClickTypeEnum_ClickType = 55
	// Shopping - Comparison Listing.
	ClickTypeEnum_SHOPPING_COMPARISON_LISTING ClickTypeEnum_ClickType = 56
)

// Enum value maps for ClickTypeEnum_ClickType.
var (
	ClickTypeEnum_ClickType_name = map[int32]string{
		0:  "UNSPECIFIED",
		1:  "UNKNOWN",
		2:  "APP_DEEPLINK",
		3:  "BREADCRUMBS",
		4:  "BROADBAND_PLAN",
		5:  "CALL_TRACKING",
		6:  "CALLS",
		7:  "CLICK_ON_ENGAGEMENT_AD",
		8:  "GET_DIRECTIONS",
		9:  "LOCATION_EXPANSION",
		10: "LOCATION_FORMAT_CALL",
		11: "LOCATION_FORMAT_DIRECTIONS",
		12: "LOCATION_FORMAT_IMAGE",
		13: "LOCATION_FORMAT_LANDING_PAGE",
		14: "LOCATION_FORMAT_MAP",
		15: "LOCATION_FORMAT_STORE_INFO",
		16: "LOCATION_FORMAT_TEXT",
		17: "MOBILE_CALL_TRACKING",
		18: "OFFER_PRINTS",
		19: "OTHER",
		20: "PRODUCT_EXTENSION_CLICKS",
		21: "PRODUCT_LISTING_AD_CLICKS",
		22: "SITELINKS",
		23: "STORE_LOCATOR",
		25: "URL_CLICKS",
		26: "VIDEO_APP_STORE_CLICKS",
		27: "VIDEO_CALL_TO_ACTION_CLICKS",
		28: "VIDEO_CARD_ACTION_HEADLINE_CLICKS",
		29: "VIDEO_END_CAP_CLICKS",
		30: "VIDEO_WEBSITE_CLICKS",
		31: "VISUAL_SITELINKS",
		32: "WIRELESS_PLAN",
		33: "PRODUCT_LISTING_AD_LOCAL",
		34: "PRODUCT_LISTING_AD_MULTICHANNEL_LOCAL",
		35: "PRODUCT_LISTING_AD_MULTICHANNEL_ONLINE",
		36: "PRODUCT_LISTING_ADS_COUPON",
		37: "PRODUCT_LISTING_AD_TRANSACTABLE",
		38: "PRODUCT_AD_APP_DEEPLINK",
		39: "SHOWCASE_AD_CATEGORY_LINK",
		40: "SHOWCASE_AD_LOCAL_STOREFRONT_LINK",
		42: "SHOWCASE_AD_ONLINE_PRODUCT_LINK",
		43: "SHOWCASE_AD_LOCAL_PRODUCT_LINK",
		44: "PROMOTION_EXTENSION",
		45: "SWIPEABLE_GALLERY_AD_HEADLINE",
		46: "SWIPEABLE_GALLERY_AD_SWIPES",
		47: "SWIPEABLE_GALLERY_AD_SEE_MORE",
		48: "SWIPEABLE_GALLERY_AD_SITELINK_ONE",
		49: "SWIPEABLE_GALLERY_AD_SITELINK_TWO",
		50: "SWIPEABLE_GALLERY_AD_SITELINK_THREE",
		51: "SWIPEABLE_GALLERY_AD_SITELINK_FOUR",
		52: "SWIPEABLE_GALLERY_AD_SITELINK_FIVE",
		53: "HOTEL_PRICE",
		54: "PRICE_EXTENSION",
		55: "HOTEL_BOOK_ON_GOOGLE_ROOM_SELECTION",
		56: "SHOPPING_COMPARISON_LISTING",
	}
	ClickTypeEnum_ClickType_value = map[string]int32{
		"UNSPECIFIED":                            0,
		"UNKNOWN":                                1,
		"APP_DEEPLINK":                           2,
		"BREADCRUMBS":                            3,
		"BROADBAND_PLAN":                         4,
		"CALL_TRACKING":                          5,
		"CALLS":                                  6,
		"CLICK_ON_ENGAGEMENT_AD":                 7,
		"GET_DIRECTIONS":                         8,
		"LOCATION_EXPANSION":                     9,
		"LOCATION_FORMAT_CALL":                   10,
		"LOCATION_FORMAT_DIRECTIONS":             11,
		"LOCATION_FORMAT_IMAGE":                  12,
		"LOCATION_FORMAT_LANDING_PAGE":           13,
		"LOCATION_FORMAT_MAP":                    14,
		"LOCATION_FORMAT_STORE_INFO":             15,
		"LOCATION_FORMAT_TEXT":                   16,
		"MOBILE_CALL_TRACKING":                   17,
		"OFFER_PRINTS":                           18,
		"OTHER":                                  19,
		"PRODUCT_EXTENSION_CLICKS":               20,
		"PRODUCT_LISTING_AD_CLICKS":              21,
		"SITELINKS":                              22,
		"STORE_LOCATOR":                          23,
		"URL_CLICKS":                             25,
		"VIDEO_APP_STORE_CLICKS":                 26,
		"VIDEO_CALL_TO_ACTION_CLICKS":            27,
		"VIDEO_CARD_ACTION_HEADLINE_CLICKS":      28,
		"VIDEO_END_CAP_CLICKS":                   29,
		"VIDEO_WEBSITE_CLICKS":                   30,
		"VISUAL_SITELINKS":                       31,
		"WIRELESS_PLAN":                          32,
		"PRODUCT_LISTING_AD_LOCAL":               33,
		"PRODUCT_LISTING_AD_MULTICHANNEL_LOCAL":  34,
		"PRODUCT_LISTING_AD_MULTICHANNEL_ONLINE": 35,
		"PRODUCT_LISTING_ADS_COUPON":             36,
		"PRODUCT_LISTING_AD_TRANSACTABLE":        37,
		"PRODUCT_AD_APP_DEEPLINK":                38,
		"SHOWCASE_AD_CATEGORY_LINK":              39,
		"SHOWCASE_AD_LOCAL_STOREFRONT_LINK":      40,
		"SHOWCASE_AD_ONLINE_PRODUCT_LINK":        42,
		"SHOWCASE_AD_LOCAL_PRODUCT_LINK":         43,
		"PROMOTION_EXTENSION":                    44,
		"SWIPEABLE_GALLERY_AD_HEADLINE":          45,
		"SWIPEABLE_GALLERY_AD_SWIPES":            46,
		"SWIPEABLE_GALLERY_AD_SEE_MORE":          47,
		"SWIPEABLE_GALLERY_AD_SITELINK_ONE":      48,
		"SWIPEABLE_GALLERY_AD_SITELINK_TWO":      49,
		"SWIPEABLE_GALLERY_AD_SITELINK_THREE":    50,
		"SWIPEABLE_GALLERY_AD_SITELINK_FOUR":     51,
		"SWIPEABLE_GALLERY_AD_SITELINK_FIVE":     52,
		"HOTEL_PRICE":                            53,
		"PRICE_EXTENSION":                        54,
		"HOTEL_BOOK_ON_GOOGLE_ROOM_SELECTION":    55,
		"SHOPPING_COMPARISON_LISTING":            56,
	}
)

func (x ClickTypeEnum_ClickType) Enum() *ClickTypeEnum_ClickType {
	p := new(ClickTypeEnum_ClickType)
	*p = x
	return p
}

func (x ClickTypeEnum_ClickType) String() string {
	return protoimpl.X.EnumStringOf(x.Descriptor(), protoreflect.EnumNumber(x))
}

func (ClickTypeEnum_ClickType) Descriptor() protoreflect.EnumDescriptor {
	return file_google_ads_googleads_v4_enums_click_type_proto_enumTypes[0].Descriptor()
}

func (ClickTypeEnum_ClickType) Type() protoreflect.EnumType {
	return &file_google_ads_googleads_v4_enums_click_type_proto_enumTypes[0]
}

func (x ClickTypeEnum_ClickType) Number() protoreflect.EnumNumber {
	return protoreflect.EnumNumber(x)
}

// Deprecated: Use ClickTypeEnum_ClickType.Descriptor instead.
func (ClickTypeEnum_ClickType) EnumDescriptor() ([]byte, []int) {
	return file_google_ads_googleads_v4_enums_click_type_proto_rawDescGZIP(), []int{0, 0}
}

// Container for enumeration of Google Ads click types.
type ClickTypeEnum struct {
	state         protoimpl.MessageState
	sizeCache     protoimpl.SizeCache
	unknownFields protoimpl.UnknownFields
}

func (x *ClickTypeEnum) Reset() {
	*x = ClickTypeEnum{}
	if protoimpl.UnsafeEnabled {
		mi := &file_google_ads_googleads_v4_enums_click_type_proto_msgTypes[0]
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		ms.StoreMessageInfo(mi)
	}
}

func (x *ClickTypeEnum) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*ClickTypeEnum) ProtoMessage() {}

func (x *ClickTypeEnum) ProtoReflect() protoreflect.Message {
	mi := &file_google_ads_googleads_v4_enums_click_type_proto_msgTypes[0]
	if protoimpl.UnsafeEnabled && x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use ClickTypeEnum.ProtoReflect.Descriptor instead.
func (*ClickTypeEnum) Descriptor() ([]byte, []int) {
	return file_google_ads_googleads_v4_enums_click_type_proto_rawDescGZIP(), []int{0}
}

var File_google_ads_googleads_v4_enums_click_type_proto protoreflect.FileDescriptor

var file_google_ads_googleads_v4_enums_click_type_proto_rawDesc = []byte{
	0x0a, 0x2e, 0x67, 0x6f, 0x6f, 0x67, 0x6c, 0x65, 0x2f, 0x61, 0x64, 0x73, 0x2f, 0x67, 0x6f, 0x6f,
	0x67, 0x6c, 0x65, 0x61, 0x64, 0x73, 0x2f, 0x76, 0x34, 0x2f, 0x65, 0x6e, 0x75, 0x6d, 0x73, 0x2f,
	0x63, 0x6c, 0x69, 0x63, 0x6b, 0x5f, 0x74, 0x79, 0x70, 0x65, 0x2e, 0x70, 0x72, 0x6f, 0x74, 0x6f,
	0x12, 0x1d, 0x67, 0x6f, 0x6f, 0x67, 0x6c, 0x65, 0x2e, 0x61, 0x64, 0x73, 0x2e, 0x67, 0x6f, 0x6f,
	0x67, 0x6c, 0x65, 0x61, 0x64, 0x73, 0x2e, 0x76, 0x34, 0x2e, 0x65, 0x6e, 0x75, 0x6d, 0x73, 0x1a,
	0x1c, 0x67, 0x6f, 0x6f, 0x67, 0x6c, 0x65, 0x2f, 0x61, 0x70, 0x69, 0x2f, 0x61, 0x6e, 0x6e, 0x6f,
	0x74, 0x61, 0x74, 0x69, 0x6f, 0x6e, 0x73, 0x2e, 0x70, 0x72, 0x6f, 0x74, 0x6f, 0x22, 0xa6, 0x0c,
	0x0a, 0x0d, 0x43, 0x6c, 0x69, 0x63, 0x6b, 0x54, 0x79, 0x70, 0x65, 0x45, 0x6e, 0x75, 0x6d, 0x22,
	0x94, 0x0c, 0x0a, 0x09, 0x43, 0x6c, 0x69, 0x63, 0x6b, 0x54, 0x79, 0x70, 0x65, 0x12, 0x0f, 0x0a,
	0x0b, 0x55, 0x4e, 0x53, 0x50, 0x45, 0x43, 0x49, 0x46, 0x49, 0x45, 0x44, 0x10, 0x00, 0x12, 0x0b,
	0x0a, 0x07, 0x55, 0x4e, 0x4b, 0x4e, 0x4f, 0x57, 0x4e, 0x10, 0x01, 0x12, 0x10, 0x0a, 0x0c, 0x41,
	0x50, 0x50, 0x5f, 0x44, 0x45, 0x45, 0x50, 0x4c, 0x49, 0x4e, 0x4b, 0x10, 0x02, 0x12, 0x0f, 0x0a,
	0x0b, 0x42, 0x52, 0x45, 0x41, 0x44, 0x43, 0x52, 0x55, 0x4d, 0x42, 0x53, 0x10, 0x03, 0x12, 0x12,
	0x0a, 0x0e, 0x42, 0x52, 0x4f, 0x41, 0x44, 0x42, 0x41, 0x4e, 0x44, 0x5f, 0x50, 0x4c, 0x41, 0x4e,
	0x10, 0x04, 0x12, 0x11, 0x0a, 0x0d, 0x43, 0x41, 0x4c, 0x4c, 0x5f, 0x54, 0x52, 0x41, 0x43, 0x4b,
	0x49, 0x4e, 0x47, 0x10, 0x05, 0x12, 0x09, 0x0a, 0x05, 0x43, 0x41, 0x4c, 0x4c, 0x53, 0x10, 0x06,
	0x12, 0x1a, 0x0a, 0x16, 0x43, 0x4c, 0x49, 0x43, 0x4b, 0x5f, 0x4f, 0x4e, 0x5f, 0x45, 0x4e, 0x47,
	0x41, 0x47, 0x45, 0x4d, 0x45, 0x4e, 0x54, 0x5f, 0x41, 0x44, 0x10, 0x07, 0x12, 0x12, 0x0a, 0x0e,
	0x47, 0x45, 0x54, 0x5f, 0x44, 0x49, 0x52, 0x45, 0x43, 0x54, 0x49, 0x4f, 0x4e, 0x53, 0x10, 0x08,
	0x12, 0x16, 0x0a, 0x12, 0x4c, 0x4f, 0x43, 0x41, 0x54, 0x49, 0x4f, 0x4e, 0x5f, 0x45, 0x58, 0x50,
	0x41, 0x4e, 0x53, 0x49, 0x4f, 0x4e, 0x10, 0x09, 0x12, 0x18, 0x0a, 0x14, 0x4c, 0x4f, 0x43, 0x41,
	0x54, 0x49, 0x4f, 0x4e, 0x5f, 0x46, 0x4f, 0x52, 0x4d, 0x41, 0x54, 0x5f, 0x43, 0x41, 0x4c, 0x4c,
	0x10, 0x0a, 0x12, 0x1e, 0x0a, 0x1a, 0x4c, 0x4f, 0x43, 0x41, 0x54, 0x49, 0x4f, 0x4e, 0x5f, 0x46,
	0x4f, 0x52, 0x4d, 0x41, 0x54, 0x5f, 0x44, 0x49, 0x52, 0x45, 0x43, 0x54, 0x49, 0x4f, 0x4e, 0x53,
	0x10, 0x0b, 0x12, 0x19, 0x0a, 0x15, 0x4c, 0x4f, 0x43, 0x41, 0x54, 0x49, 0x4f, 0x4e, 0x5f, 0x46,
	0x4f, 0x52, 0x4d, 0x41, 0x54, 0x5f, 0x49, 0x4d, 0x41, 0x47, 0x45, 0x10, 0x0c, 0x12, 0x20, 0x0a,
	0x1c, 0x4c, 0x4f, 0x43, 0x41, 0x54, 0x49, 0x4f, 0x4e, 0x5f, 0x46, 0x4f, 0x52, 0x4d, 0x41, 0x54,
	0x5f, 0x4c, 0x41, 0x4e, 0x44, 0x49, 0x4e, 0x47, 0x5f, 0x50, 0x41, 0x47, 0x45, 0x10, 0x0d, 0x12,
	0x17, 0x0a, 0x13, 0x4c, 0x4f, 0x43, 0x41, 0x54, 0x49, 0x4f, 0x4e, 0x5f, 0x46, 0x4f, 0x52, 0x4d,
	0x41, 0x54, 0x5f, 0x4d, 0x41, 0x50, 0x10, 0x0e, 0x12, 0x1e, 0x0a, 0x1a, 0x4c, 0x4f, 0x43, 0x41,
	0x54, 0x49, 0x4f, 0x4e, 0x5f, 0x46, 0x4f, 0x52, 0x4d, 0x41, 0x54, 0x5f, 0x53, 0x54, 0x4f, 0x52,
	0x45, 0x5f, 0x49, 0x4e, 0x46, 0x4f, 0x10, 0x0f, 0x12, 0x18, 0x0a, 0x14, 0x4c, 0x4f, 0x43, 0x41,
	0x54, 0x49, 0x4f, 0x4e, 0x5f, 0x46, 0x4f, 0x52, 0x4d, 0x41, 0x54, 0x5f, 0x54, 0x45, 0x58, 0x54,
	0x10, 0x10, 0x12, 0x18, 0x0a, 0x14, 0x4d, 0x4f, 0x42, 0x49, 0x4c, 0x45, 0x5f, 0x43, 0x41, 0x4c,
	0x4c, 0x5f, 0x54, 0x52, 0x41, 0x43, 0x4b, 0x49, 0x4e, 0x47, 0x10, 0x11, 0x12, 0x10, 0x0a, 0x0c,
	0x4f, 0x46, 0x46, 0x45, 0x52, 0x5f, 0x50, 0x52, 0x49, 0x4e, 0x54, 0x53, 0x10, 0x12, 0x12, 0x09,
	0x0a, 0x05, 0x4f, 0x54, 0x48, 0x45, 0x52, 0x10, 0x13, 0x12, 0x1c, 0x0a, 0x18, 0x50, 0x52, 0x4f,
	0x44, 0x55, 0x43, 0x54, 0x5f, 0x45, 0x58, 0x54, 0x45, 0x4e, 0x53, 0x49, 0x4f, 0x4e, 0x5f, 0x43,
	0x4c, 0x49, 0x43, 0x4b, 0x53, 0x10, 0x14, 0x12, 0x1d, 0x0a, 0x19, 0x50, 0x52, 0x4f, 0x44, 0x55,
	0x43, 0x54, 0x5f, 0x4c, 0x49, 0x53, 0x54, 0x49, 0x4e, 0x47, 0x5f, 0x41, 0x44, 0x5f, 0x43, 0x4c,
	0x49, 0x43, 0x4b, 0x53, 0x10, 0x15, 0x12, 0x0d, 0x0a, 0x09, 0x53, 0x49, 0x54, 0x45, 0x4c, 0x49,
	0x4e, 0x4b, 0x53, 0x10, 0x16, 0x12, 0x11, 0x0a, 0x0d, 0x53, 0x54, 0x4f, 0x52, 0x45, 0x5f, 0x4c,
	0x4f, 0x43, 0x41, 0x54, 0x4f, 0x52, 0x10, 0x17, 0x12, 0x0e, 0x0a, 0x0a, 0x55, 0x52, 0x4c, 0x5f,
	0x43, 0x4c, 0x49, 0x43, 0x4b, 0x53, 0x10, 0x19, 0x12, 0x1a, 0x0a, 0x16, 0x56, 0x49, 0x44, 0x45,
	0x4f, 0x5f, 0x41, 0x50, 0x50, 0x5f, 0x53, 0x54, 0x4f, 0x52, 0x45, 0x5f, 0x43, 0x4c, 0x49, 0x43,
	0x4b, 0x53, 0x10, 0x1a, 0x12, 0x1f, 0x0a, 0x1b, 0x56, 0x49, 0x44, 0x45, 0x4f, 0x5f, 0x43, 0x41,
	0x4c, 0x4c, 0x5f, 0x54, 0x4f, 0x5f, 0x41, 0x43, 0x54, 0x49, 0x4f, 0x4e, 0x5f, 0x43, 0x4c, 0x49,
	0x43, 0x4b, 0x53, 0x10, 0x1b, 0x12, 0x25, 0x0a, 0x21, 0x56, 0x49, 0x44, 0x45, 0x4f, 0x5f, 0x43,
	0x41, 0x52, 0x44, 0x5f, 0x41, 0x43, 0x54, 0x49, 0x4f, 0x4e, 0x5f, 0x48, 0x45, 0x41, 0x44, 0x4c,
	0x49, 0x4e, 0x45, 0x5f, 0x43, 0x4c, 0x49, 0x43, 0x4b, 0x53, 0x10, 0x1c, 0x12, 0x18, 0x0a, 0x14,
	0x56, 0x49, 0x44, 0x45, 0x4f, 0x5f, 0x45, 0x4e, 0x44, 0x5f, 0x43, 0x41, 0x50, 0x5f, 0x43, 0x4c,
	0x49, 0x43, 0x4b, 0x53, 0x10, 0x1d, 0x12, 0x18, 0x0a, 0x14, 0x56, 0x49, 0x44, 0x45, 0x4f, 0x5f,
	0x57, 0x45, 0x42, 0x53, 0x49, 0x54, 0x45, 0x5f, 0x43, 0x4c, 0x49, 0x43, 0x4b, 0x53, 0x10, 0x1e,
	0x12, 0x14, 0x0a, 0x10, 0x56, 0x49, 0x53, 0x55, 0x41, 0x4c, 0x5f, 0x53, 0x49, 0x54, 0x45, 0x4c,
	0x49, 0x4e, 0x4b, 0x53, 0x10, 0x1f, 0x12, 0x11, 0x0a, 0x0d, 0x57, 0x49, 0x52, 0x45, 0x4c, 0x45,
	0x53, 0x53, 0x5f, 0x50, 0x4c, 0x41, 0x4e, 0x10, 0x20, 0x12, 0x1c, 0x0a, 0x18, 0x50, 0x52, 0x4f,
	0x44, 0x55, 0x43, 0x54, 0x5f, 0x4c, 0x49, 0x53, 0x54, 0x49, 0x4e, 0x47, 0x5f, 0x41, 0x44, 0x5f,
	0x4c, 0x4f, 0x43, 0x41, 0x4c, 0x10, 0x21, 0x12, 0x29, 0x0a, 0x25, 0x50, 0x52, 0x4f, 0x44, 0x55,
	0x43, 0x54, 0x5f, 0x4c, 0x49, 0x53, 0x54, 0x49, 0x4e, 0x47, 0x5f, 0x41, 0x44, 0x5f, 0x4d, 0x55,
	0x4c, 0x54, 0x49, 0x43, 0x48, 0x41, 0x4e, 0x4e, 0x45, 0x4c, 0x5f, 0x4c, 0x4f, 0x43, 0x41, 0x4c,
	0x10, 0x22, 0x12, 0x2a, 0x0a, 0x26, 0x50, 0x52, 0x4f, 0x44, 0x55, 0x43, 0x54, 0x5f, 0x4c, 0x49,
	0x53, 0x54, 0x49, 0x4e, 0x47, 0x5f, 0x41, 0x44, 0x5f, 0x4d, 0x55, 0x4c, 0x54, 0x49, 0x43, 0x48,
	0x41, 0x4e, 0x4e, 0x45, 0x4c, 0x5f, 0x4f, 0x4e, 0x4c, 0x49, 0x4e, 0x45, 0x10, 0x23, 0x12, 0x1e,
	0x0a, 0x1a, 0x50, 0x52, 0x4f, 0x44, 0x55, 0x43, 0x54, 0x5f, 0x4c, 0x49, 0x53, 0x54, 0x49, 0x4e,
	0x47, 0x5f, 0x41, 0x44, 0x53, 0x5f, 0x43, 0x4f, 0x55, 0x50, 0x4f, 0x4e, 0x10, 0x24, 0x12, 0x23,
	0x0a, 0x1f, 0x50, 0x52, 0x4f, 0x44, 0x55, 0x43, 0x54, 0x5f, 0x4c, 0x49, 0x53, 0x54, 0x49, 0x4e,
	0x47, 0x5f, 0x41, 0x44, 0x5f, 0x54, 0x52, 0x41, 0x4e, 0x53, 0x41, 0x43, 0x54, 0x41, 0x42, 0x4c,
	0x45, 0x10, 0x25, 0x12, 0x1b, 0x0a, 0x17, 0x50, 0x52, 0x4f, 0x44, 0x55, 0x43, 0x54, 0x5f, 0x41,
	0x44, 0x5f, 0x41, 0x50, 0x50, 0x5f, 0x44, 0x45, 0x45, 0x50, 0x4c, 0x49, 0x4e, 0x4b, 0x10, 0x26,
	0x12, 0x1d, 0x0a, 0x19, 0x53, 0x48, 0x4f, 0x57, 0x43, 0x41, 0x53, 0x45, 0x5f, 0x41, 0x44, 0x5f,
	0x43, 0x41, 0x54, 0x45, 0x47, 0x4f, 0x52, 0x59, 0x5f, 0x4c, 0x49, 0x4e, 0x4b, 0x10, 0x27, 0x12,
	0x25, 0x0a, 0x21, 0x53, 0x48, 0x4f, 0x57, 0x43, 0x41, 0x53, 0x45, 0x5f, 0x41, 0x44, 0x5f, 0x4c,
	0x4f, 0x43, 0x41, 0x4c, 0x5f, 0x53, 0x54, 0x4f, 0x52, 0x45, 0x46, 0x52, 0x4f, 0x4e, 0x54, 0x5f,
	0x4c, 0x49, 0x4e, 0x4b, 0x10, 0x28, 0x12, 0x23, 0x0a, 0x1f, 0x53, 0x48, 0x4f, 0x57, 0x43, 0x41,
	0x53, 0x45, 0x5f, 0x41, 0x44, 0x5f, 0x4f, 0x4e, 0x4c, 0x49, 0x4e, 0x45, 0x5f, 0x50, 0x52, 0x4f,
	0x44, 0x55, 0x43, 0x54, 0x5f, 0x4c, 0x49, 0x4e, 0x4b, 0x10, 0x2a, 0x12, 0x22, 0x0a, 0x1e, 0x53,
	0x48, 0x4f, 0x57, 0x43, 0x41, 0x53, 0x45, 0x5f, 0x41, 0x44, 0x5f, 0x4c, 0x4f, 0x43, 0x41, 0x4c,
	0x5f, 0x50, 0x52, 0x4f, 0x44, 0x55, 0x43, 0x54, 0x5f, 0x4c, 0x49, 0x4e, 0x4b, 0x10, 0x2b, 0x12,
	0x17, 0x0a, 0x13, 0x50, 0x52, 0x4f, 0x4d, 0x4f, 0x54, 0x49, 0x4f, 0x4e, 0x5f, 0x45, 0x58, 0x54,
	0x45, 0x4e, 0x53, 0x49, 0x4f, 0x4e, 0x10, 0x2c, 0x12, 0x21, 0x0a, 0x1d, 0x53, 0x57, 0x49, 0x50,
	0x45, 0x41, 0x42, 0x4c, 0x45, 0x5f, 0x47, 0x41, 0x4c, 0x4c, 0x45, 0x52, 0x59, 0x5f, 0x41, 0x44,
	0x5f, 0x48, 0x45, 0x41, 0x44, 0x4c, 0x49, 0x4e, 0x45, 0x10, 0x2d, 0x12, 0x1f, 0x0a, 0x1b, 0x53,
	0x57, 0x49, 0x50, 0x45, 0x41, 0x42, 0x4c, 0x45, 0x5f, 0x47, 0x41, 0x4c, 0x4c, 0x45, 0x52, 0x59,
	0x5f, 0x41, 0x44, 0x5f, 0x53, 0x57, 0x49, 0x50, 0x45, 0x53, 0x10, 0x2e, 0x12, 0x21, 0x0a, 0x1d,
	0x53, 0x57, 0x49, 0x50, 0x45, 0x41, 0x42, 0x4c, 0x45, 0x5f, 0x47, 0x41, 0x4c, 0x4c, 0x45, 0x52,
	0x59, 0x5f, 0x41, 0x44, 0x5f, 0x53, 0x45, 0x45, 0x5f, 0x4d, 0x4f, 0x52, 0x45, 0x10, 0x2f, 0x12,
	0x25, 0x0a, 0x21, 0x53, 0x57, 0x49, 0x50, 0x45, 0x41, 0x42, 0x4c, 0x45, 0x5f, 0x47, 0x41, 0x4c,
	0x4c, 0x45, 0x52, 0x59, 0x5f, 0x41, 0x44, 0x5f, 0x53, 0x49, 0x54, 0x45, 0x4c, 0x49, 0x4e, 0x4b,
	0x5f, 0x4f, 0x4e, 0x45, 0x10, 0x30, 0x12, 0x25, 0x0a, 0x21, 0x53, 0x57, 0x49, 0x50, 0x45, 0x41,
	0x42, 0x4c, 0x45, 0x5f, 0x47, 0x41, 0x4c, 0x4c, 0x45, 0x52, 0x59, 0x5f, 0x41, 0x44, 0x5f, 0x53,
	0x49, 0x54, 0x45, 0x4c, 0x49, 0x4e, 0x4b, 0x5f, 0x54, 0x57, 0x4f, 0x10, 0x31, 0x12, 0x27, 0x0a,
	0x23, 0x53, 0x57, 0x49, 0x50, 0x45, 0x41, 0x42, 0x4c, 0x45, 0x5f, 0x47, 0x41, 0x4c, 0x4c, 0x45,
	0x52, 0x59, 0x5f, 0x41, 0x44, 0x5f, 0x53, 0x49, 0x54, 0x45, 0x4c, 0x49, 0x4e, 0x4b, 0x5f, 0x54,
	0x48, 0x52, 0x45, 0x45, 0x10, 0x32, 0x12, 0x26, 0x0a, 0x22, 0x53, 0x57, 0x49, 0x50, 0x45, 0x41,
	0x42, 0x4c, 0x45, 0x5f, 0x47, 0x41, 0x4c, 0x4c, 0x45, 0x52, 0x59, 0x5f, 0x41, 0x44, 0x5f, 0x53,
	0x49, 0x54, 0x45, 0x4c, 0x49, 0x4e, 0x4b, 0x5f, 0x46, 0x4f, 0x55, 0x52, 0x10, 0x33, 0x12, 0x26,
	0x0a, 0x22, 0x53, 0x57, 0x49, 0x50, 0x45, 0x41, 0x42, 0x4c, 0x45, 0x5f, 0x47, 0x41, 0x4c, 0x4c,
	0x45, 0x52, 0x59, 0x5f, 0x41, 0x44, 0x5f, 0x53, 0x49, 0x54, 0x45, 0x4c, 0x49, 0x4e, 0x4b, 0x5f,
	0x46, 0x49, 0x56, 0x45, 0x10, 0x34, 0x12, 0x0f, 0x0a, 0x0b, 0x48, 0x4f, 0x54, 0x45, 0x4c, 0x5f,
	0x50, 0x52, 0x49, 0x43, 0x45, 0x10, 0x35, 0x12, 0x13, 0x0a, 0x0f, 0x50, 0x52, 0x49, 0x43, 0x45,
	0x5f, 0x45, 0x58, 0x54, 0x45, 0x4e, 0x53, 0x49, 0x4f, 0x4e, 0x10, 0x36, 0x12, 0x27, 0x0a, 0x23,
	0x48, 0x4f, 0x54, 0x45, 0x4c, 0x5f, 0x42, 0x4f, 0x4f, 0x4b, 0x5f, 0x4f, 0x4e, 0x5f, 0x47, 0x4f,
	0x4f, 0x47, 0x4c, 0x45, 0x5f, 0x52, 0x4f, 0x4f, 0x4d, 0x5f, 0x53, 0x45, 0x4c, 0x45, 0x43, 0x54,
	0x49, 0x4f, 0x4e, 0x10, 0x37, 0x12, 0x1f, 0x0a, 0x1b, 0x53, 0x48, 0x4f, 0x50, 0x50, 0x49, 0x4e,
	0x47, 0x5f, 0x43, 0x4f, 0x4d, 0x50, 0x41, 0x52, 0x49, 0x53, 0x4f, 0x4e, 0x5f, 0x4c, 0x49, 0x53,
	0x54, 0x49, 0x4e, 0x47, 0x10, 0x38, 0x42, 0xe3, 0x01, 0x0a, 0x21, 0x63, 0x6f, 0x6d, 0x2e, 0x67,
	0x6f, 0x6f, 0x67, 0x6c, 0x65, 0x2e, 0x61, 0x64, 0x73, 0x2e, 0x67, 0x6f, 0x6f, 0x67, 0x6c, 0x65,
	0x61, 0x64, 0x73, 0x2e, 0x76, 0x34, 0x2e, 0x65, 0x6e, 0x75, 0x6d, 0x73, 0x42, 0x0e, 0x43, 0x6c,
	0x69, 0x63, 0x6b, 0x54, 0x79, 0x70, 0x65, 0x50, 0x72, 0x6f, 0x74, 0x6f, 0x50, 0x01, 0x5a, 0x42,
	0x67, 0x6f, 0x6f, 0x67, 0x6c, 0x65, 0x2e, 0x67, 0x6f, 0x6c, 0x61, 0x6e, 0x67, 0x2e, 0x6f, 0x72,
	0x67, 0x2f, 0x67, 0x65, 0x6e, 0x70, 0x72, 0x6f, 0x74, 0x6f, 0x2f, 0x67, 0x6f, 0x6f, 0x67, 0x6c,
	0x65, 0x61, 0x70, 0x69, 0x73, 0x2f, 0x61, 0x64, 0x73, 0x2f, 0x67, 0x6f, 0x6f, 0x67, 0x6c, 0x65,
	0x61, 0x64, 0x73, 0x2f, 0x76, 0x34, 0x2f, 0x65, 0x6e, 0x75, 0x6d, 0x73, 0x3b, 0x65, 0x6e, 0x75,
	0x6d, 0x73, 0xa2, 0x02, 0x03, 0x47, 0x41, 0x41, 0xaa, 0x02, 0x1d, 0x47, 0x6f, 0x6f, 0x67, 0x6c,
	0x65, 0x2e, 0x41, 0x64, 0x73, 0x2e, 0x47, 0x6f, 0x6f, 0x67, 0x6c, 0x65, 0x41, 0x64, 0x73, 0x2e,
	0x56, 0x34, 0x2e, 0x45, 0x6e, 0x75, 0x6d, 0x73, 0xca, 0x02, 0x1d, 0x47, 0x6f, 0x6f, 0x67, 0x6c,
	0x65, 0x5c, 0x41, 0x64, 0x73, 0x5c, 0x47, 0x6f, 0x6f, 0x67, 0x6c, 0x65, 0x41, 0x64, 0x73, 0x5c,
	0x56, 0x34, 0x5c, 0x45, 0x6e, 0x75, 0x6d, 0x73, 0xea, 0x02, 0x21, 0x47, 0x6f, 0x6f, 0x67, 0x6c,
	0x65, 0x3a, 0x3a, 0x41, 0x64, 0x73, 0x3a, 0x3a, 0x47, 0x6f, 0x6f, 0x67, 0x6c, 0x65, 0x41, 0x64,
	0x73, 0x3a, 0x3a, 0x56, 0x34, 0x3a, 0x3a, 0x45, 0x6e, 0x75, 0x6d, 0x73, 0x62, 0x06, 0x70, 0x72,
	0x6f, 0x74, 0x6f, 0x33,
}

var (
	file_google_ads_googleads_v4_enums_click_type_proto_rawDescOnce sync.Once
	file_google_ads_googleads_v4_enums_click_type_proto_rawDescData = file_google_ads_googleads_v4_enums_click_type_proto_rawDesc
)

func file_google_ads_googleads_v4_enums_click_type_proto_rawDescGZIP() []byte {
	file_google_ads_googleads_v4_enums_click_type_proto_rawDescOnce.Do(func() {
		file_google_ads_googleads_v4_enums_click_type_proto_rawDescData = protoimpl.X.CompressGZIP(file_google_ads_googleads_v4_enums_click_type_proto_rawDescData)
	})
	return file_google_ads_googleads_v4_enums_click_type_proto_rawDescData
}

var file_google_ads_googleads_v4_enums_click_type_proto_enumTypes = make([]protoimpl.EnumInfo, 1)
var file_google_ads_googleads_v4_enums_click_type_proto_msgTypes = make([]protoimpl.MessageInfo, 1)
var file_google_ads_googleads_v4_enums_click_type_proto_goTypes = []interface{}{
	(ClickTypeEnum_ClickType)(0), // 0: google.ads.googleads.v4.enums.ClickTypeEnum.ClickType
	(*ClickTypeEnum)(nil),        // 1: google.ads.googleads.v4.enums.ClickTypeEnum
}
var file_google_ads_googleads_v4_enums_click_type_proto_depIdxs = []int32{
	0, // [0:0] is the sub-list for method output_type
	0, // [0:0] is the sub-list for method input_type
	0, // [0:0] is the sub-list for extension type_name
	0, // [0:0] is the sub-list for extension extendee
	0, // [0:0] is the sub-list for field type_name
}

func init() { file_google_ads_googleads_v4_enums_click_type_proto_init() }
func file_google_ads_googleads_v4_enums_click_type_proto_init() {
	if File_google_ads_googleads_v4_enums_click_type_proto != nil {
		return
	}
	if !protoimpl.UnsafeEnabled {
		file_google_ads_googleads_v4_enums_click_type_proto_msgTypes[0].Exporter = func(v interface{}, i int) interface{} {
			switch v := v.(*ClickTypeEnum); i {
			case 0:
				return &v.state
			case 1:
				return &v.sizeCache
			case 2:
				return &v.unknownFields
			default:
				return nil
			}
		}
	}
	type x struct{}
	out := protoimpl.TypeBuilder{
		File: protoimpl.DescBuilder{
			GoPackagePath: reflect.TypeOf(x{}).PkgPath(),
			RawDescriptor: file_google_ads_googleads_v4_enums_click_type_proto_rawDesc,
			NumEnums:      1,
			NumMessages:   1,
			NumExtensions: 0,
			NumServices:   0,
		},
		GoTypes:           file_google_ads_googleads_v4_enums_click_type_proto_goTypes,
		DependencyIndexes: file_google_ads_googleads_v4_enums_click_type_proto_depIdxs,
		EnumInfos:         file_google_ads_googleads_v4_enums_click_type_proto_enumTypes,
		MessageInfos:      file_google_ads_googleads_v4_enums_click_type_proto_msgTypes,
	}.Build()
	File_google_ads_googleads_v4_enums_click_type_proto = out.File
	file_google_ads_googleads_v4_enums_click_type_proto_rawDesc = nil
	file_google_ads_googleads_v4_enums_click_type_proto_goTypes = nil
	file_google_ads_googleads_v4_enums_click_type_proto_depIdxs = nil
}
