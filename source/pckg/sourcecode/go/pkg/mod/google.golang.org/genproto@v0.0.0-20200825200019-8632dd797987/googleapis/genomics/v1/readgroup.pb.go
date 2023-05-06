// Copyright 2016 Google Inc.
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
// source: google/genomics/v1/readgroup.proto

package genomics

import (
	reflect "reflect"
	sync "sync"

	proto "github.com/golang/protobuf/proto"
	_ "google.golang.org/genproto/googleapis/api/annotations"
	protoreflect "google.golang.org/protobuf/reflect/protoreflect"
	protoimpl "google.golang.org/protobuf/runtime/protoimpl"
	structpb "google.golang.org/protobuf/types/known/structpb"
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

// A read group is all the data that's processed the same way by the sequencer.
type ReadGroup struct {
	state         protoimpl.MessageState
	sizeCache     protoimpl.SizeCache
	unknownFields protoimpl.UnknownFields

	// The server-generated read group ID, unique for all read groups.
	// Note: This is different than the @RG ID field in the SAM spec. For that
	// value, see [name][google.genomics.v1.ReadGroup.name].
	Id string `protobuf:"bytes,1,opt,name=id,proto3" json:"id,omitempty"`
	// The dataset to which this read group belongs.
	DatasetId string `protobuf:"bytes,2,opt,name=dataset_id,json=datasetId,proto3" json:"dataset_id,omitempty"`
	// The read group name. This corresponds to the @RG ID field in the SAM spec.
	Name string `protobuf:"bytes,3,opt,name=name,proto3" json:"name,omitempty"`
	// A free-form text description of this read group.
	Description string `protobuf:"bytes,4,opt,name=description,proto3" json:"description,omitempty"`
	// A client-supplied sample identifier for the reads in this read group.
	SampleId string `protobuf:"bytes,5,opt,name=sample_id,json=sampleId,proto3" json:"sample_id,omitempty"`
	// The experiment used to generate this read group.
	Experiment *ReadGroup_Experiment `protobuf:"bytes,6,opt,name=experiment,proto3" json:"experiment,omitempty"`
	// The predicted insert size of this read group. The insert size is the length
	// the sequenced DNA fragment from end-to-end, not including the adapters.
	PredictedInsertSize int32 `protobuf:"varint,7,opt,name=predicted_insert_size,json=predictedInsertSize,proto3" json:"predicted_insert_size,omitempty"`
	// The programs used to generate this read group. Programs are always
	// identical for all read groups within a read group set. For this reason,
	// only the first read group in a returned set will have this field
	// populated.
	Programs []*ReadGroup_Program `protobuf:"bytes,10,rep,name=programs,proto3" json:"programs,omitempty"`
	// The reference set the reads in this read group are aligned to.
	ReferenceSetId string `protobuf:"bytes,11,opt,name=reference_set_id,json=referenceSetId,proto3" json:"reference_set_id,omitempty"`
	// A map of additional read group information. This must be of the form
	// map<string, string[]> (string key mapping to a list of string values).
	Info map[string]*structpb.ListValue `protobuf:"bytes,12,rep,name=info,proto3" json:"info,omitempty" protobuf_key:"bytes,1,opt,name=key,proto3" protobuf_val:"bytes,2,opt,name=value,proto3"`
}

func (x *ReadGroup) Reset() {
	*x = ReadGroup{}
	if protoimpl.UnsafeEnabled {
		mi := &file_google_genomics_v1_readgroup_proto_msgTypes[0]
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		ms.StoreMessageInfo(mi)
	}
}

func (x *ReadGroup) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*ReadGroup) ProtoMessage() {}

func (x *ReadGroup) ProtoReflect() protoreflect.Message {
	mi := &file_google_genomics_v1_readgroup_proto_msgTypes[0]
	if protoimpl.UnsafeEnabled && x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use ReadGroup.ProtoReflect.Descriptor instead.
func (*ReadGroup) Descriptor() ([]byte, []int) {
	return file_google_genomics_v1_readgroup_proto_rawDescGZIP(), []int{0}
}

func (x *ReadGroup) GetId() string {
	if x != nil {
		return x.Id
	}
	return ""
}

func (x *ReadGroup) GetDatasetId() string {
	if x != nil {
		return x.DatasetId
	}
	return ""
}

func (x *ReadGroup) GetName() string {
	if x != nil {
		return x.Name
	}
	return ""
}

func (x *ReadGroup) GetDescription() string {
	if x != nil {
		return x.Description
	}
	return ""
}

func (x *ReadGroup) GetSampleId() string {
	if x != nil {
		return x.SampleId
	}
	return ""
}

func (x *ReadGroup) GetExperiment() *ReadGroup_Experiment {
	if x != nil {
		return x.Experiment
	}
	return nil
}

func (x *ReadGroup) GetPredictedInsertSize() int32 {
	if x != nil {
		return x.PredictedInsertSize
	}
	return 0
}

func (x *ReadGroup) GetPrograms() []*ReadGroup_Program {
	if x != nil {
		return x.Programs
	}
	return nil
}

func (x *ReadGroup) GetReferenceSetId() string {
	if x != nil {
		return x.ReferenceSetId
	}
	return ""
}

func (x *ReadGroup) GetInfo() map[string]*structpb.ListValue {
	if x != nil {
		return x.Info
	}
	return nil
}

type ReadGroup_Experiment struct {
	state         protoimpl.MessageState
	sizeCache     protoimpl.SizeCache
	unknownFields protoimpl.UnknownFields

	// A client-supplied library identifier; a library is a collection of DNA
	// fragments which have been prepared for sequencing from a sample. This
	// field is important for quality control as error or bias can be introduced
	// during sample preparation.
	LibraryId string `protobuf:"bytes,1,opt,name=library_id,json=libraryId,proto3" json:"library_id,omitempty"`
	// The platform unit used as part of this experiment, for example
	// flowcell-barcode.lane for Illumina or slide for SOLiD. Corresponds to the
	// @RG PU field in the SAM spec.
	PlatformUnit string `protobuf:"bytes,2,opt,name=platform_unit,json=platformUnit,proto3" json:"platform_unit,omitempty"`
	// The sequencing center used as part of this experiment.
	SequencingCenter string `protobuf:"bytes,3,opt,name=sequencing_center,json=sequencingCenter,proto3" json:"sequencing_center,omitempty"`
	// The instrument model used as part of this experiment. This maps to
	// sequencing technology in the SAM spec.
	InstrumentModel string `protobuf:"bytes,4,opt,name=instrument_model,json=instrumentModel,proto3" json:"instrument_model,omitempty"`
}

func (x *ReadGroup_Experiment) Reset() {
	*x = ReadGroup_Experiment{}
	if protoimpl.UnsafeEnabled {
		mi := &file_google_genomics_v1_readgroup_proto_msgTypes[1]
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		ms.StoreMessageInfo(mi)
	}
}

func (x *ReadGroup_Experiment) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*ReadGroup_Experiment) ProtoMessage() {}

func (x *ReadGroup_Experiment) ProtoReflect() protoreflect.Message {
	mi := &file_google_genomics_v1_readgroup_proto_msgTypes[1]
	if protoimpl.UnsafeEnabled && x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use ReadGroup_Experiment.ProtoReflect.Descriptor instead.
func (*ReadGroup_Experiment) Descriptor() ([]byte, []int) {
	return file_google_genomics_v1_readgroup_proto_rawDescGZIP(), []int{0, 0}
}

func (x *ReadGroup_Experiment) GetLibraryId() string {
	if x != nil {
		return x.LibraryId
	}
	return ""
}

func (x *ReadGroup_Experiment) GetPlatformUnit() string {
	if x != nil {
		return x.PlatformUnit
	}
	return ""
}

func (x *ReadGroup_Experiment) GetSequencingCenter() string {
	if x != nil {
		return x.SequencingCenter
	}
	return ""
}

func (x *ReadGroup_Experiment) GetInstrumentModel() string {
	if x != nil {
		return x.InstrumentModel
	}
	return ""
}

type ReadGroup_Program struct {
	state         protoimpl.MessageState
	sizeCache     protoimpl.SizeCache
	unknownFields protoimpl.UnknownFields

	// The command line used to run this program.
	CommandLine string `protobuf:"bytes,1,opt,name=command_line,json=commandLine,proto3" json:"command_line,omitempty"`
	// The user specified locally unique ID of the program. Used along with
	// `prevProgramId` to define an ordering between programs.
	Id string `protobuf:"bytes,2,opt,name=id,proto3" json:"id,omitempty"`
	// The display name of the program. This is typically the colloquial name of
	// the tool used, for example 'bwa' or 'picard'.
	Name string `protobuf:"bytes,3,opt,name=name,proto3" json:"name,omitempty"`
	// The ID of the program run before this one.
	PrevProgramId string `protobuf:"bytes,4,opt,name=prev_program_id,json=prevProgramId,proto3" json:"prev_program_id,omitempty"`
	// The version of the program run.
	Version string `protobuf:"bytes,5,opt,name=version,proto3" json:"version,omitempty"`
}

func (x *ReadGroup_Program) Reset() {
	*x = ReadGroup_Program{}
	if protoimpl.UnsafeEnabled {
		mi := &file_google_genomics_v1_readgroup_proto_msgTypes[2]
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		ms.StoreMessageInfo(mi)
	}
}

func (x *ReadGroup_Program) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*ReadGroup_Program) ProtoMessage() {}

func (x *ReadGroup_Program) ProtoReflect() protoreflect.Message {
	mi := &file_google_genomics_v1_readgroup_proto_msgTypes[2]
	if protoimpl.UnsafeEnabled && x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use ReadGroup_Program.ProtoReflect.Descriptor instead.
func (*ReadGroup_Program) Descriptor() ([]byte, []int) {
	return file_google_genomics_v1_readgroup_proto_rawDescGZIP(), []int{0, 1}
}

func (x *ReadGroup_Program) GetCommandLine() string {
	if x != nil {
		return x.CommandLine
	}
	return ""
}

func (x *ReadGroup_Program) GetId() string {
	if x != nil {
		return x.Id
	}
	return ""
}

func (x *ReadGroup_Program) GetName() string {
	if x != nil {
		return x.Name
	}
	return ""
}

func (x *ReadGroup_Program) GetPrevProgramId() string {
	if x != nil {
		return x.PrevProgramId
	}
	return ""
}

func (x *ReadGroup_Program) GetVersion() string {
	if x != nil {
		return x.Version
	}
	return ""
}

var File_google_genomics_v1_readgroup_proto protoreflect.FileDescriptor

var file_google_genomics_v1_readgroup_proto_rawDesc = []byte{
	0x0a, 0x22, 0x67, 0x6f, 0x6f, 0x67, 0x6c, 0x65, 0x2f, 0x67, 0x65, 0x6e, 0x6f, 0x6d, 0x69, 0x63,
	0x73, 0x2f, 0x76, 0x31, 0x2f, 0x72, 0x65, 0x61, 0x64, 0x67, 0x72, 0x6f, 0x75, 0x70, 0x2e, 0x70,
	0x72, 0x6f, 0x74, 0x6f, 0x12, 0x12, 0x67, 0x6f, 0x6f, 0x67, 0x6c, 0x65, 0x2e, 0x67, 0x65, 0x6e,
	0x6f, 0x6d, 0x69, 0x63, 0x73, 0x2e, 0x76, 0x31, 0x1a, 0x1c, 0x67, 0x6f, 0x6f, 0x67, 0x6c, 0x65,
	0x2f, 0x61, 0x70, 0x69, 0x2f, 0x61, 0x6e, 0x6e, 0x6f, 0x74, 0x61, 0x74, 0x69, 0x6f, 0x6e, 0x73,
	0x2e, 0x70, 0x72, 0x6f, 0x74, 0x6f, 0x1a, 0x1c, 0x67, 0x6f, 0x6f, 0x67, 0x6c, 0x65, 0x2f, 0x70,
	0x72, 0x6f, 0x74, 0x6f, 0x62, 0x75, 0x66, 0x2f, 0x73, 0x74, 0x72, 0x75, 0x63, 0x74, 0x2e, 0x70,
	0x72, 0x6f, 0x74, 0x6f, 0x22, 0xca, 0x06, 0x0a, 0x09, 0x52, 0x65, 0x61, 0x64, 0x47, 0x72, 0x6f,
	0x75, 0x70, 0x12, 0x0e, 0x0a, 0x02, 0x69, 0x64, 0x18, 0x01, 0x20, 0x01, 0x28, 0x09, 0x52, 0x02,
	0x69, 0x64, 0x12, 0x1d, 0x0a, 0x0a, 0x64, 0x61, 0x74, 0x61, 0x73, 0x65, 0x74, 0x5f, 0x69, 0x64,
	0x18, 0x02, 0x20, 0x01, 0x28, 0x09, 0x52, 0x09, 0x64, 0x61, 0x74, 0x61, 0x73, 0x65, 0x74, 0x49,
	0x64, 0x12, 0x12, 0x0a, 0x04, 0x6e, 0x61, 0x6d, 0x65, 0x18, 0x03, 0x20, 0x01, 0x28, 0x09, 0x52,
	0x04, 0x6e, 0x61, 0x6d, 0x65, 0x12, 0x20, 0x0a, 0x0b, 0x64, 0x65, 0x73, 0x63, 0x72, 0x69, 0x70,
	0x74, 0x69, 0x6f, 0x6e, 0x18, 0x04, 0x20, 0x01, 0x28, 0x09, 0x52, 0x0b, 0x64, 0x65, 0x73, 0x63,
	0x72, 0x69, 0x70, 0x74, 0x69, 0x6f, 0x6e, 0x12, 0x1b, 0x0a, 0x09, 0x73, 0x61, 0x6d, 0x70, 0x6c,
	0x65, 0x5f, 0x69, 0x64, 0x18, 0x05, 0x20, 0x01, 0x28, 0x09, 0x52, 0x08, 0x73, 0x61, 0x6d, 0x70,
	0x6c, 0x65, 0x49, 0x64, 0x12, 0x48, 0x0a, 0x0a, 0x65, 0x78, 0x70, 0x65, 0x72, 0x69, 0x6d, 0x65,
	0x6e, 0x74, 0x18, 0x06, 0x20, 0x01, 0x28, 0x0b, 0x32, 0x28, 0x2e, 0x67, 0x6f, 0x6f, 0x67, 0x6c,
	0x65, 0x2e, 0x67, 0x65, 0x6e, 0x6f, 0x6d, 0x69, 0x63, 0x73, 0x2e, 0x76, 0x31, 0x2e, 0x52, 0x65,
	0x61, 0x64, 0x47, 0x72, 0x6f, 0x75, 0x70, 0x2e, 0x45, 0x78, 0x70, 0x65, 0x72, 0x69, 0x6d, 0x65,
	0x6e, 0x74, 0x52, 0x0a, 0x65, 0x78, 0x70, 0x65, 0x72, 0x69, 0x6d, 0x65, 0x6e, 0x74, 0x12, 0x32,
	0x0a, 0x15, 0x70, 0x72, 0x65, 0x64, 0x69, 0x63, 0x74, 0x65, 0x64, 0x5f, 0x69, 0x6e, 0x73, 0x65,
	0x72, 0x74, 0x5f, 0x73, 0x69, 0x7a, 0x65, 0x18, 0x07, 0x20, 0x01, 0x28, 0x05, 0x52, 0x13, 0x70,
	0x72, 0x65, 0x64, 0x69, 0x63, 0x74, 0x65, 0x64, 0x49, 0x6e, 0x73, 0x65, 0x72, 0x74, 0x53, 0x69,
	0x7a, 0x65, 0x12, 0x41, 0x0a, 0x08, 0x70, 0x72, 0x6f, 0x67, 0x72, 0x61, 0x6d, 0x73, 0x18, 0x0a,
	0x20, 0x03, 0x28, 0x0b, 0x32, 0x25, 0x2e, 0x67, 0x6f, 0x6f, 0x67, 0x6c, 0x65, 0x2e, 0x67, 0x65,
	0x6e, 0x6f, 0x6d, 0x69, 0x63, 0x73, 0x2e, 0x76, 0x31, 0x2e, 0x52, 0x65, 0x61, 0x64, 0x47, 0x72,
	0x6f, 0x75, 0x70, 0x2e, 0x50, 0x72, 0x6f, 0x67, 0x72, 0x61, 0x6d, 0x52, 0x08, 0x70, 0x72, 0x6f,
	0x67, 0x72, 0x61, 0x6d, 0x73, 0x12, 0x28, 0x0a, 0x10, 0x72, 0x65, 0x66, 0x65, 0x72, 0x65, 0x6e,
	0x63, 0x65, 0x5f, 0x73, 0x65, 0x74, 0x5f, 0x69, 0x64, 0x18, 0x0b, 0x20, 0x01, 0x28, 0x09, 0x52,
	0x0e, 0x72, 0x65, 0x66, 0x65, 0x72, 0x65, 0x6e, 0x63, 0x65, 0x53, 0x65, 0x74, 0x49, 0x64, 0x12,
	0x3b, 0x0a, 0x04, 0x69, 0x6e, 0x66, 0x6f, 0x18, 0x0c, 0x20, 0x03, 0x28, 0x0b, 0x32, 0x27, 0x2e,
	0x67, 0x6f, 0x6f, 0x67, 0x6c, 0x65, 0x2e, 0x67, 0x65, 0x6e, 0x6f, 0x6d, 0x69, 0x63, 0x73, 0x2e,
	0x76, 0x31, 0x2e, 0x52, 0x65, 0x61, 0x64, 0x47, 0x72, 0x6f, 0x75, 0x70, 0x2e, 0x49, 0x6e, 0x66,
	0x6f, 0x45, 0x6e, 0x74, 0x72, 0x79, 0x52, 0x04, 0x69, 0x6e, 0x66, 0x6f, 0x1a, 0xa8, 0x01, 0x0a,
	0x0a, 0x45, 0x78, 0x70, 0x65, 0x72, 0x69, 0x6d, 0x65, 0x6e, 0x74, 0x12, 0x1d, 0x0a, 0x0a, 0x6c,
	0x69, 0x62, 0x72, 0x61, 0x72, 0x79, 0x5f, 0x69, 0x64, 0x18, 0x01, 0x20, 0x01, 0x28, 0x09, 0x52,
	0x09, 0x6c, 0x69, 0x62, 0x72, 0x61, 0x72, 0x79, 0x49, 0x64, 0x12, 0x23, 0x0a, 0x0d, 0x70, 0x6c,
	0x61, 0x74, 0x66, 0x6f, 0x72, 0x6d, 0x5f, 0x75, 0x6e, 0x69, 0x74, 0x18, 0x02, 0x20, 0x01, 0x28,
	0x09, 0x52, 0x0c, 0x70, 0x6c, 0x61, 0x74, 0x66, 0x6f, 0x72, 0x6d, 0x55, 0x6e, 0x69, 0x74, 0x12,
	0x2b, 0x0a, 0x11, 0x73, 0x65, 0x71, 0x75, 0x65, 0x6e, 0x63, 0x69, 0x6e, 0x67, 0x5f, 0x63, 0x65,
	0x6e, 0x74, 0x65, 0x72, 0x18, 0x03, 0x20, 0x01, 0x28, 0x09, 0x52, 0x10, 0x73, 0x65, 0x71, 0x75,
	0x65, 0x6e, 0x63, 0x69, 0x6e, 0x67, 0x43, 0x65, 0x6e, 0x74, 0x65, 0x72, 0x12, 0x29, 0x0a, 0x10,
	0x69, 0x6e, 0x73, 0x74, 0x72, 0x75, 0x6d, 0x65, 0x6e, 0x74, 0x5f, 0x6d, 0x6f, 0x64, 0x65, 0x6c,
	0x18, 0x04, 0x20, 0x01, 0x28, 0x09, 0x52, 0x0f, 0x69, 0x6e, 0x73, 0x74, 0x72, 0x75, 0x6d, 0x65,
	0x6e, 0x74, 0x4d, 0x6f, 0x64, 0x65, 0x6c, 0x1a, 0x92, 0x01, 0x0a, 0x07, 0x50, 0x72, 0x6f, 0x67,
	0x72, 0x61, 0x6d, 0x12, 0x21, 0x0a, 0x0c, 0x63, 0x6f, 0x6d, 0x6d, 0x61, 0x6e, 0x64, 0x5f, 0x6c,
	0x69, 0x6e, 0x65, 0x18, 0x01, 0x20, 0x01, 0x28, 0x09, 0x52, 0x0b, 0x63, 0x6f, 0x6d, 0x6d, 0x61,
	0x6e, 0x64, 0x4c, 0x69, 0x6e, 0x65, 0x12, 0x0e, 0x0a, 0x02, 0x69, 0x64, 0x18, 0x02, 0x20, 0x01,
	0x28, 0x09, 0x52, 0x02, 0x69, 0x64, 0x12, 0x12, 0x0a, 0x04, 0x6e, 0x61, 0x6d, 0x65, 0x18, 0x03,
	0x20, 0x01, 0x28, 0x09, 0x52, 0x04, 0x6e, 0x61, 0x6d, 0x65, 0x12, 0x26, 0x0a, 0x0f, 0x70, 0x72,
	0x65, 0x76, 0x5f, 0x70, 0x72, 0x6f, 0x67, 0x72, 0x61, 0x6d, 0x5f, 0x69, 0x64, 0x18, 0x04, 0x20,
	0x01, 0x28, 0x09, 0x52, 0x0d, 0x70, 0x72, 0x65, 0x76, 0x50, 0x72, 0x6f, 0x67, 0x72, 0x61, 0x6d,
	0x49, 0x64, 0x12, 0x18, 0x0a, 0x07, 0x76, 0x65, 0x72, 0x73, 0x69, 0x6f, 0x6e, 0x18, 0x05, 0x20,
	0x01, 0x28, 0x09, 0x52, 0x07, 0x76, 0x65, 0x72, 0x73, 0x69, 0x6f, 0x6e, 0x1a, 0x53, 0x0a, 0x09,
	0x49, 0x6e, 0x66, 0x6f, 0x45, 0x6e, 0x74, 0x72, 0x79, 0x12, 0x10, 0x0a, 0x03, 0x6b, 0x65, 0x79,
	0x18, 0x01, 0x20, 0x01, 0x28, 0x09, 0x52, 0x03, 0x6b, 0x65, 0x79, 0x12, 0x30, 0x0a, 0x05, 0x76,
	0x61, 0x6c, 0x75, 0x65, 0x18, 0x02, 0x20, 0x01, 0x28, 0x0b, 0x32, 0x1a, 0x2e, 0x67, 0x6f, 0x6f,
	0x67, 0x6c, 0x65, 0x2e, 0x70, 0x72, 0x6f, 0x74, 0x6f, 0x62, 0x75, 0x66, 0x2e, 0x4c, 0x69, 0x73,
	0x74, 0x56, 0x61, 0x6c, 0x75, 0x65, 0x52, 0x05, 0x76, 0x61, 0x6c, 0x75, 0x65, 0x3a, 0x02, 0x38,
	0x01, 0x42, 0x69, 0x0a, 0x16, 0x63, 0x6f, 0x6d, 0x2e, 0x67, 0x6f, 0x6f, 0x67, 0x6c, 0x65, 0x2e,
	0x67, 0x65, 0x6e, 0x6f, 0x6d, 0x69, 0x63, 0x73, 0x2e, 0x76, 0x31, 0x42, 0x0e, 0x52, 0x65, 0x61,
	0x64, 0x47, 0x72, 0x6f, 0x75, 0x70, 0x50, 0x72, 0x6f, 0x74, 0x6f, 0x50, 0x01, 0x5a, 0x3a, 0x67,
	0x6f, 0x6f, 0x67, 0x6c, 0x65, 0x2e, 0x67, 0x6f, 0x6c, 0x61, 0x6e, 0x67, 0x2e, 0x6f, 0x72, 0x67,
	0x2f, 0x67, 0x65, 0x6e, 0x70, 0x72, 0x6f, 0x74, 0x6f, 0x2f, 0x67, 0x6f, 0x6f, 0x67, 0x6c, 0x65,
	0x61, 0x70, 0x69, 0x73, 0x2f, 0x67, 0x65, 0x6e, 0x6f, 0x6d, 0x69, 0x63, 0x73, 0x2f, 0x76, 0x31,
	0x3b, 0x67, 0x65, 0x6e, 0x6f, 0x6d, 0x69, 0x63, 0x73, 0xf8, 0x01, 0x01, 0x62, 0x06, 0x70, 0x72,
	0x6f, 0x74, 0x6f, 0x33,
}

var (
	file_google_genomics_v1_readgroup_proto_rawDescOnce sync.Once
	file_google_genomics_v1_readgroup_proto_rawDescData = file_google_genomics_v1_readgroup_proto_rawDesc
)

func file_google_genomics_v1_readgroup_proto_rawDescGZIP() []byte {
	file_google_genomics_v1_readgroup_proto_rawDescOnce.Do(func() {
		file_google_genomics_v1_readgroup_proto_rawDescData = protoimpl.X.CompressGZIP(file_google_genomics_v1_readgroup_proto_rawDescData)
	})
	return file_google_genomics_v1_readgroup_proto_rawDescData
}

var file_google_genomics_v1_readgroup_proto_msgTypes = make([]protoimpl.MessageInfo, 4)
var file_google_genomics_v1_readgroup_proto_goTypes = []interface{}{
	(*ReadGroup)(nil),            // 0: google.genomics.v1.ReadGroup
	(*ReadGroup_Experiment)(nil), // 1: google.genomics.v1.ReadGroup.Experiment
	(*ReadGroup_Program)(nil),    // 2: google.genomics.v1.ReadGroup.Program
	nil,                          // 3: google.genomics.v1.ReadGroup.InfoEntry
	(*structpb.ListValue)(nil),   // 4: google.protobuf.ListValue
}
var file_google_genomics_v1_readgroup_proto_depIdxs = []int32{
	1, // 0: google.genomics.v1.ReadGroup.experiment:type_name -> google.genomics.v1.ReadGroup.Experiment
	2, // 1: google.genomics.v1.ReadGroup.programs:type_name -> google.genomics.v1.ReadGroup.Program
	3, // 2: google.genomics.v1.ReadGroup.info:type_name -> google.genomics.v1.ReadGroup.InfoEntry
	4, // 3: google.genomics.v1.ReadGroup.InfoEntry.value:type_name -> google.protobuf.ListValue
	4, // [4:4] is the sub-list for method output_type
	4, // [4:4] is the sub-list for method input_type
	4, // [4:4] is the sub-list for extension type_name
	4, // [4:4] is the sub-list for extension extendee
	0, // [0:4] is the sub-list for field type_name
}

func init() { file_google_genomics_v1_readgroup_proto_init() }
func file_google_genomics_v1_readgroup_proto_init() {
	if File_google_genomics_v1_readgroup_proto != nil {
		return
	}
	if !protoimpl.UnsafeEnabled {
		file_google_genomics_v1_readgroup_proto_msgTypes[0].Exporter = func(v interface{}, i int) interface{} {
			switch v := v.(*ReadGroup); i {
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
		file_google_genomics_v1_readgroup_proto_msgTypes[1].Exporter = func(v interface{}, i int) interface{} {
			switch v := v.(*ReadGroup_Experiment); i {
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
		file_google_genomics_v1_readgroup_proto_msgTypes[2].Exporter = func(v interface{}, i int) interface{} {
			switch v := v.(*ReadGroup_Program); i {
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
			RawDescriptor: file_google_genomics_v1_readgroup_proto_rawDesc,
			NumEnums:      0,
			NumMessages:   4,
			NumExtensions: 0,
			NumServices:   0,
		},
		GoTypes:           file_google_genomics_v1_readgroup_proto_goTypes,
		DependencyIndexes: file_google_genomics_v1_readgroup_proto_depIdxs,
		MessageInfos:      file_google_genomics_v1_readgroup_proto_msgTypes,
	}.Build()
	File_google_genomics_v1_readgroup_proto = out.File
	file_google_genomics_v1_readgroup_proto_rawDesc = nil
	file_google_genomics_v1_readgroup_proto_goTypes = nil
	file_google_genomics_v1_readgroup_proto_depIdxs = nil
}
