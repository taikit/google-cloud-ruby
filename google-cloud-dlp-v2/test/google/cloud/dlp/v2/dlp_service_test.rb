# frozen_string_literal: true

# Copyright 2020 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require "simplecov"
require "minitest/autorun"

require "gapic/grpc/service_stub"

require "google/privacy/dlp/v2/dlp_pb"
require "google/privacy/dlp/v2/dlp_services_pb"
require "google/cloud/dlp/v2/dlp_service"

class ::Google::Cloud::Dlp::V2::DlpService::ClientTest < Minitest::Test
  class ClientStub
    attr_accessor :call_rpc_count, :requests

    def initialize response, operation, &block
      @response = response
      @operation = operation
      @block = block
      @call_rpc_count = 0
      @requests = []
    end

    def call_rpc *args
      @call_rpc_count += 1

      @requests << @block&.call(*args)

      yield @response, @operation if block_given?

      @response
    end
  end

  def test_inspect_content
    # Create GRPC objects.
    grpc_response = ::Google::Cloud::Dlp::V2::InspectContentResponse.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    parent = "hello world"
    inspect_config = {}
    item = {}
    inspect_template_name = "hello world"
    location_id = "hello world"

    inspect_content_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :inspect_content, name
      assert_kind_of ::Google::Cloud::Dlp::V2::InspectContentRequest, request
      assert_equal "hello world", request.parent
      assert_equal Gapic::Protobuf.coerce({}, to: ::Google::Cloud::Dlp::V2::InspectConfig), request.inspect_config
      assert_equal Gapic::Protobuf.coerce({}, to: ::Google::Cloud::Dlp::V2::ContentItem), request.item
      assert_equal "hello world", request.inspect_template_name
      assert_equal "hello world", request.location_id
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, inspect_content_client_stub do
      # Create client
      client = ::Google::Cloud::Dlp::V2::DlpService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.inspect_content({ parent: parent, inspect_config: inspect_config, item: item, inspect_template_name: inspect_template_name, location_id: location_id }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.inspect_content parent: parent, inspect_config: inspect_config, item: item, inspect_template_name: inspect_template_name, location_id: location_id do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.inspect_content ::Google::Cloud::Dlp::V2::InspectContentRequest.new(parent: parent, inspect_config: inspect_config, item: item, inspect_template_name: inspect_template_name, location_id: location_id) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.inspect_content({ parent: parent, inspect_config: inspect_config, item: item, inspect_template_name: inspect_template_name, location_id: location_id }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.inspect_content ::Google::Cloud::Dlp::V2::InspectContentRequest.new(parent: parent, inspect_config: inspect_config, item: item, inspect_template_name: inspect_template_name, location_id: location_id), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, inspect_content_client_stub.call_rpc_count
    end
  end

  def test_redact_image
    # Create GRPC objects.
    grpc_response = ::Google::Cloud::Dlp::V2::RedactImageResponse.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    parent = "hello world"
    location_id = "hello world"
    inspect_config = {}
    image_redaction_configs = [{}]
    include_findings = true
    byte_item = {}

    redact_image_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :redact_image, name
      assert_kind_of ::Google::Cloud::Dlp::V2::RedactImageRequest, request
      assert_equal "hello world", request.parent
      assert_equal "hello world", request.location_id
      assert_equal Gapic::Protobuf.coerce({}, to: ::Google::Cloud::Dlp::V2::InspectConfig), request.inspect_config
      assert_kind_of ::Google::Cloud::Dlp::V2::RedactImageRequest::ImageRedactionConfig, request.image_redaction_configs.first
      assert_equal true, request.include_findings
      assert_equal Gapic::Protobuf.coerce({}, to: ::Google::Cloud::Dlp::V2::ByteContentItem), request.byte_item
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, redact_image_client_stub do
      # Create client
      client = ::Google::Cloud::Dlp::V2::DlpService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.redact_image({ parent: parent, location_id: location_id, inspect_config: inspect_config, image_redaction_configs: image_redaction_configs, include_findings: include_findings, byte_item: byte_item }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.redact_image parent: parent, location_id: location_id, inspect_config: inspect_config, image_redaction_configs: image_redaction_configs, include_findings: include_findings, byte_item: byte_item do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.redact_image ::Google::Cloud::Dlp::V2::RedactImageRequest.new(parent: parent, location_id: location_id, inspect_config: inspect_config, image_redaction_configs: image_redaction_configs, include_findings: include_findings, byte_item: byte_item) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.redact_image({ parent: parent, location_id: location_id, inspect_config: inspect_config, image_redaction_configs: image_redaction_configs, include_findings: include_findings, byte_item: byte_item }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.redact_image ::Google::Cloud::Dlp::V2::RedactImageRequest.new(parent: parent, location_id: location_id, inspect_config: inspect_config, image_redaction_configs: image_redaction_configs, include_findings: include_findings, byte_item: byte_item), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, redact_image_client_stub.call_rpc_count
    end
  end

  def test_deidentify_content
    # Create GRPC objects.
    grpc_response = ::Google::Cloud::Dlp::V2::DeidentifyContentResponse.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    parent = "hello world"
    deidentify_config = {}
    inspect_config = {}
    item = {}
    inspect_template_name = "hello world"
    deidentify_template_name = "hello world"
    location_id = "hello world"

    deidentify_content_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :deidentify_content, name
      assert_kind_of ::Google::Cloud::Dlp::V2::DeidentifyContentRequest, request
      assert_equal "hello world", request.parent
      assert_equal Gapic::Protobuf.coerce({}, to: ::Google::Cloud::Dlp::V2::DeidentifyConfig), request.deidentify_config
      assert_equal Gapic::Protobuf.coerce({}, to: ::Google::Cloud::Dlp::V2::InspectConfig), request.inspect_config
      assert_equal Gapic::Protobuf.coerce({}, to: ::Google::Cloud::Dlp::V2::ContentItem), request.item
      assert_equal "hello world", request.inspect_template_name
      assert_equal "hello world", request.deidentify_template_name
      assert_equal "hello world", request.location_id
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, deidentify_content_client_stub do
      # Create client
      client = ::Google::Cloud::Dlp::V2::DlpService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.deidentify_content({ parent: parent, deidentify_config: deidentify_config, inspect_config: inspect_config, item: item, inspect_template_name: inspect_template_name, deidentify_template_name: deidentify_template_name, location_id: location_id }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.deidentify_content parent: parent, deidentify_config: deidentify_config, inspect_config: inspect_config, item: item, inspect_template_name: inspect_template_name, deidentify_template_name: deidentify_template_name, location_id: location_id do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.deidentify_content ::Google::Cloud::Dlp::V2::DeidentifyContentRequest.new(parent: parent, deidentify_config: deidentify_config, inspect_config: inspect_config, item: item, inspect_template_name: inspect_template_name, deidentify_template_name: deidentify_template_name, location_id: location_id) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.deidentify_content({ parent: parent, deidentify_config: deidentify_config, inspect_config: inspect_config, item: item, inspect_template_name: inspect_template_name, deidentify_template_name: deidentify_template_name, location_id: location_id }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.deidentify_content ::Google::Cloud::Dlp::V2::DeidentifyContentRequest.new(parent: parent, deidentify_config: deidentify_config, inspect_config: inspect_config, item: item, inspect_template_name: inspect_template_name, deidentify_template_name: deidentify_template_name, location_id: location_id), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, deidentify_content_client_stub.call_rpc_count
    end
  end

  def test_reidentify_content
    # Create GRPC objects.
    grpc_response = ::Google::Cloud::Dlp::V2::ReidentifyContentResponse.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    parent = "hello world"
    reidentify_config = {}
    inspect_config = {}
    item = {}
    inspect_template_name = "hello world"
    reidentify_template_name = "hello world"
    location_id = "hello world"

    reidentify_content_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :reidentify_content, name
      assert_kind_of ::Google::Cloud::Dlp::V2::ReidentifyContentRequest, request
      assert_equal "hello world", request.parent
      assert_equal Gapic::Protobuf.coerce({}, to: ::Google::Cloud::Dlp::V2::DeidentifyConfig), request.reidentify_config
      assert_equal Gapic::Protobuf.coerce({}, to: ::Google::Cloud::Dlp::V2::InspectConfig), request.inspect_config
      assert_equal Gapic::Protobuf.coerce({}, to: ::Google::Cloud::Dlp::V2::ContentItem), request.item
      assert_equal "hello world", request.inspect_template_name
      assert_equal "hello world", request.reidentify_template_name
      assert_equal "hello world", request.location_id
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, reidentify_content_client_stub do
      # Create client
      client = ::Google::Cloud::Dlp::V2::DlpService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.reidentify_content({ parent: parent, reidentify_config: reidentify_config, inspect_config: inspect_config, item: item, inspect_template_name: inspect_template_name, reidentify_template_name: reidentify_template_name, location_id: location_id }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.reidentify_content parent: parent, reidentify_config: reidentify_config, inspect_config: inspect_config, item: item, inspect_template_name: inspect_template_name, reidentify_template_name: reidentify_template_name, location_id: location_id do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.reidentify_content ::Google::Cloud::Dlp::V2::ReidentifyContentRequest.new(parent: parent, reidentify_config: reidentify_config, inspect_config: inspect_config, item: item, inspect_template_name: inspect_template_name, reidentify_template_name: reidentify_template_name, location_id: location_id) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.reidentify_content({ parent: parent, reidentify_config: reidentify_config, inspect_config: inspect_config, item: item, inspect_template_name: inspect_template_name, reidentify_template_name: reidentify_template_name, location_id: location_id }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.reidentify_content ::Google::Cloud::Dlp::V2::ReidentifyContentRequest.new(parent: parent, reidentify_config: reidentify_config, inspect_config: inspect_config, item: item, inspect_template_name: inspect_template_name, reidentify_template_name: reidentify_template_name, location_id: location_id), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, reidentify_content_client_stub.call_rpc_count
    end
  end

  def test_list_info_types
    # Create GRPC objects.
    grpc_response = ::Google::Cloud::Dlp::V2::ListInfoTypesResponse.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    language_code = "hello world"
    filter = "hello world"
    location_id = "hello world"

    list_info_types_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :list_info_types, name
      assert_kind_of ::Google::Cloud::Dlp::V2::ListInfoTypesRequest, request
      assert_equal "hello world", request.language_code
      assert_equal "hello world", request.filter
      assert_equal "hello world", request.location_id
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, list_info_types_client_stub do
      # Create client
      client = ::Google::Cloud::Dlp::V2::DlpService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.list_info_types({ language_code: language_code, filter: filter, location_id: location_id }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.list_info_types language_code: language_code, filter: filter, location_id: location_id do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.list_info_types ::Google::Cloud::Dlp::V2::ListInfoTypesRequest.new(language_code: language_code, filter: filter, location_id: location_id) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.list_info_types({ language_code: language_code, filter: filter, location_id: location_id }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.list_info_types ::Google::Cloud::Dlp::V2::ListInfoTypesRequest.new(language_code: language_code, filter: filter, location_id: location_id), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, list_info_types_client_stub.call_rpc_count
    end
  end

  def test_create_inspect_template
    # Create GRPC objects.
    grpc_response = ::Google::Cloud::Dlp::V2::InspectTemplate.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    parent = "hello world"
    inspect_template = {}
    template_id = "hello world"
    location_id = "hello world"

    create_inspect_template_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :create_inspect_template, name
      assert_kind_of ::Google::Cloud::Dlp::V2::CreateInspectTemplateRequest, request
      assert_equal "hello world", request.parent
      assert_equal Gapic::Protobuf.coerce({}, to: ::Google::Cloud::Dlp::V2::InspectTemplate), request.inspect_template
      assert_equal "hello world", request.template_id
      assert_equal "hello world", request.location_id
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, create_inspect_template_client_stub do
      # Create client
      client = ::Google::Cloud::Dlp::V2::DlpService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.create_inspect_template({ parent: parent, inspect_template: inspect_template, template_id: template_id, location_id: location_id }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.create_inspect_template parent: parent, inspect_template: inspect_template, template_id: template_id, location_id: location_id do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.create_inspect_template ::Google::Cloud::Dlp::V2::CreateInspectTemplateRequest.new(parent: parent, inspect_template: inspect_template, template_id: template_id, location_id: location_id) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.create_inspect_template({ parent: parent, inspect_template: inspect_template, template_id: template_id, location_id: location_id }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.create_inspect_template ::Google::Cloud::Dlp::V2::CreateInspectTemplateRequest.new(parent: parent, inspect_template: inspect_template, template_id: template_id, location_id: location_id), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, create_inspect_template_client_stub.call_rpc_count
    end
  end

  def test_update_inspect_template
    # Create GRPC objects.
    grpc_response = ::Google::Cloud::Dlp::V2::InspectTemplate.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    name = "hello world"
    inspect_template = {}
    update_mask = {}

    update_inspect_template_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :update_inspect_template, name
      assert_kind_of ::Google::Cloud::Dlp::V2::UpdateInspectTemplateRequest, request
      assert_equal "hello world", request.name
      assert_equal Gapic::Protobuf.coerce({}, to: ::Google::Cloud::Dlp::V2::InspectTemplate), request.inspect_template
      assert_equal Gapic::Protobuf.coerce({}, to: ::Google::Protobuf::FieldMask), request.update_mask
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, update_inspect_template_client_stub do
      # Create client
      client = ::Google::Cloud::Dlp::V2::DlpService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.update_inspect_template({ name: name, inspect_template: inspect_template, update_mask: update_mask }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.update_inspect_template name: name, inspect_template: inspect_template, update_mask: update_mask do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.update_inspect_template ::Google::Cloud::Dlp::V2::UpdateInspectTemplateRequest.new(name: name, inspect_template: inspect_template, update_mask: update_mask) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.update_inspect_template({ name: name, inspect_template: inspect_template, update_mask: update_mask }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.update_inspect_template ::Google::Cloud::Dlp::V2::UpdateInspectTemplateRequest.new(name: name, inspect_template: inspect_template, update_mask: update_mask), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, update_inspect_template_client_stub.call_rpc_count
    end
  end

  def test_get_inspect_template
    # Create GRPC objects.
    grpc_response = ::Google::Cloud::Dlp::V2::InspectTemplate.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    name = "hello world"

    get_inspect_template_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :get_inspect_template, name
      assert_kind_of ::Google::Cloud::Dlp::V2::GetInspectTemplateRequest, request
      assert_equal "hello world", request.name
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, get_inspect_template_client_stub do
      # Create client
      client = ::Google::Cloud::Dlp::V2::DlpService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.get_inspect_template({ name: name }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.get_inspect_template name: name do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.get_inspect_template ::Google::Cloud::Dlp::V2::GetInspectTemplateRequest.new(name: name) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.get_inspect_template({ name: name }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.get_inspect_template ::Google::Cloud::Dlp::V2::GetInspectTemplateRequest.new(name: name), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, get_inspect_template_client_stub.call_rpc_count
    end
  end

  def test_list_inspect_templates
    # Create GRPC objects.
    grpc_response = ::Google::Cloud::Dlp::V2::ListInspectTemplatesResponse.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    parent = "hello world"
    page_token = "hello world"
    page_size = 42
    order_by = "hello world"
    location_id = "hello world"

    list_inspect_templates_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :list_inspect_templates, name
      assert_kind_of ::Google::Cloud::Dlp::V2::ListInspectTemplatesRequest, request
      assert_equal "hello world", request.parent
      assert_equal "hello world", request.page_token
      assert_equal 42, request.page_size
      assert_equal "hello world", request.order_by
      assert_equal "hello world", request.location_id
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, list_inspect_templates_client_stub do
      # Create client
      client = ::Google::Cloud::Dlp::V2::DlpService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.list_inspect_templates({ parent: parent, page_token: page_token, page_size: page_size, order_by: order_by, location_id: location_id }) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.list_inspect_templates parent: parent, page_token: page_token, page_size: page_size, order_by: order_by, location_id: location_id do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.list_inspect_templates ::Google::Cloud::Dlp::V2::ListInspectTemplatesRequest.new(parent: parent, page_token: page_token, page_size: page_size, order_by: order_by, location_id: location_id) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.list_inspect_templates({ parent: parent, page_token: page_token, page_size: page_size, order_by: order_by, location_id: location_id }, grpc_options) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.list_inspect_templates ::Google::Cloud::Dlp::V2::ListInspectTemplatesRequest.new(parent: parent, page_token: page_token, page_size: page_size, order_by: order_by, location_id: location_id), grpc_options do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, list_inspect_templates_client_stub.call_rpc_count
    end
  end

  def test_delete_inspect_template
    # Create GRPC objects.
    grpc_response = ::Google::Protobuf::Empty.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    name = "hello world"

    delete_inspect_template_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :delete_inspect_template, name
      assert_kind_of ::Google::Cloud::Dlp::V2::DeleteInspectTemplateRequest, request
      assert_equal "hello world", request.name
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, delete_inspect_template_client_stub do
      # Create client
      client = ::Google::Cloud::Dlp::V2::DlpService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.delete_inspect_template({ name: name }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.delete_inspect_template name: name do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.delete_inspect_template ::Google::Cloud::Dlp::V2::DeleteInspectTemplateRequest.new(name: name) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.delete_inspect_template({ name: name }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.delete_inspect_template ::Google::Cloud::Dlp::V2::DeleteInspectTemplateRequest.new(name: name), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, delete_inspect_template_client_stub.call_rpc_count
    end
  end

  def test_create_deidentify_template
    # Create GRPC objects.
    grpc_response = ::Google::Cloud::Dlp::V2::DeidentifyTemplate.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    parent = "hello world"
    deidentify_template = {}
    template_id = "hello world"
    location_id = "hello world"

    create_deidentify_template_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :create_deidentify_template, name
      assert_kind_of ::Google::Cloud::Dlp::V2::CreateDeidentifyTemplateRequest, request
      assert_equal "hello world", request.parent
      assert_equal Gapic::Protobuf.coerce({}, to: ::Google::Cloud::Dlp::V2::DeidentifyTemplate), request.deidentify_template
      assert_equal "hello world", request.template_id
      assert_equal "hello world", request.location_id
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, create_deidentify_template_client_stub do
      # Create client
      client = ::Google::Cloud::Dlp::V2::DlpService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.create_deidentify_template({ parent: parent, deidentify_template: deidentify_template, template_id: template_id, location_id: location_id }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.create_deidentify_template parent: parent, deidentify_template: deidentify_template, template_id: template_id, location_id: location_id do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.create_deidentify_template ::Google::Cloud::Dlp::V2::CreateDeidentifyTemplateRequest.new(parent: parent, deidentify_template: deidentify_template, template_id: template_id, location_id: location_id) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.create_deidentify_template({ parent: parent, deidentify_template: deidentify_template, template_id: template_id, location_id: location_id }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.create_deidentify_template ::Google::Cloud::Dlp::V2::CreateDeidentifyTemplateRequest.new(parent: parent, deidentify_template: deidentify_template, template_id: template_id, location_id: location_id), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, create_deidentify_template_client_stub.call_rpc_count
    end
  end

  def test_update_deidentify_template
    # Create GRPC objects.
    grpc_response = ::Google::Cloud::Dlp::V2::DeidentifyTemplate.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    name = "hello world"
    deidentify_template = {}
    update_mask = {}

    update_deidentify_template_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :update_deidentify_template, name
      assert_kind_of ::Google::Cloud::Dlp::V2::UpdateDeidentifyTemplateRequest, request
      assert_equal "hello world", request.name
      assert_equal Gapic::Protobuf.coerce({}, to: ::Google::Cloud::Dlp::V2::DeidentifyTemplate), request.deidentify_template
      assert_equal Gapic::Protobuf.coerce({}, to: ::Google::Protobuf::FieldMask), request.update_mask
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, update_deidentify_template_client_stub do
      # Create client
      client = ::Google::Cloud::Dlp::V2::DlpService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.update_deidentify_template({ name: name, deidentify_template: deidentify_template, update_mask: update_mask }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.update_deidentify_template name: name, deidentify_template: deidentify_template, update_mask: update_mask do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.update_deidentify_template ::Google::Cloud::Dlp::V2::UpdateDeidentifyTemplateRequest.new(name: name, deidentify_template: deidentify_template, update_mask: update_mask) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.update_deidentify_template({ name: name, deidentify_template: deidentify_template, update_mask: update_mask }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.update_deidentify_template ::Google::Cloud::Dlp::V2::UpdateDeidentifyTemplateRequest.new(name: name, deidentify_template: deidentify_template, update_mask: update_mask), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, update_deidentify_template_client_stub.call_rpc_count
    end
  end

  def test_get_deidentify_template
    # Create GRPC objects.
    grpc_response = ::Google::Cloud::Dlp::V2::DeidentifyTemplate.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    name = "hello world"

    get_deidentify_template_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :get_deidentify_template, name
      assert_kind_of ::Google::Cloud::Dlp::V2::GetDeidentifyTemplateRequest, request
      assert_equal "hello world", request.name
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, get_deidentify_template_client_stub do
      # Create client
      client = ::Google::Cloud::Dlp::V2::DlpService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.get_deidentify_template({ name: name }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.get_deidentify_template name: name do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.get_deidentify_template ::Google::Cloud::Dlp::V2::GetDeidentifyTemplateRequest.new(name: name) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.get_deidentify_template({ name: name }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.get_deidentify_template ::Google::Cloud::Dlp::V2::GetDeidentifyTemplateRequest.new(name: name), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, get_deidentify_template_client_stub.call_rpc_count
    end
  end

  def test_list_deidentify_templates
    # Create GRPC objects.
    grpc_response = ::Google::Cloud::Dlp::V2::ListDeidentifyTemplatesResponse.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    parent = "hello world"
    page_token = "hello world"
    page_size = 42
    order_by = "hello world"
    location_id = "hello world"

    list_deidentify_templates_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :list_deidentify_templates, name
      assert_kind_of ::Google::Cloud::Dlp::V2::ListDeidentifyTemplatesRequest, request
      assert_equal "hello world", request.parent
      assert_equal "hello world", request.page_token
      assert_equal 42, request.page_size
      assert_equal "hello world", request.order_by
      assert_equal "hello world", request.location_id
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, list_deidentify_templates_client_stub do
      # Create client
      client = ::Google::Cloud::Dlp::V2::DlpService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.list_deidentify_templates({ parent: parent, page_token: page_token, page_size: page_size, order_by: order_by, location_id: location_id }) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.list_deidentify_templates parent: parent, page_token: page_token, page_size: page_size, order_by: order_by, location_id: location_id do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.list_deidentify_templates ::Google::Cloud::Dlp::V2::ListDeidentifyTemplatesRequest.new(parent: parent, page_token: page_token, page_size: page_size, order_by: order_by, location_id: location_id) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.list_deidentify_templates({ parent: parent, page_token: page_token, page_size: page_size, order_by: order_by, location_id: location_id }, grpc_options) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.list_deidentify_templates ::Google::Cloud::Dlp::V2::ListDeidentifyTemplatesRequest.new(parent: parent, page_token: page_token, page_size: page_size, order_by: order_by, location_id: location_id), grpc_options do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, list_deidentify_templates_client_stub.call_rpc_count
    end
  end

  def test_delete_deidentify_template
    # Create GRPC objects.
    grpc_response = ::Google::Protobuf::Empty.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    name = "hello world"

    delete_deidentify_template_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :delete_deidentify_template, name
      assert_kind_of ::Google::Cloud::Dlp::V2::DeleteDeidentifyTemplateRequest, request
      assert_equal "hello world", request.name
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, delete_deidentify_template_client_stub do
      # Create client
      client = ::Google::Cloud::Dlp::V2::DlpService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.delete_deidentify_template({ name: name }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.delete_deidentify_template name: name do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.delete_deidentify_template ::Google::Cloud::Dlp::V2::DeleteDeidentifyTemplateRequest.new(name: name) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.delete_deidentify_template({ name: name }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.delete_deidentify_template ::Google::Cloud::Dlp::V2::DeleteDeidentifyTemplateRequest.new(name: name), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, delete_deidentify_template_client_stub.call_rpc_count
    end
  end

  def test_create_job_trigger
    # Create GRPC objects.
    grpc_response = ::Google::Cloud::Dlp::V2::JobTrigger.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    parent = "hello world"
    job_trigger = {}
    trigger_id = "hello world"
    location_id = "hello world"

    create_job_trigger_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :create_job_trigger, name
      assert_kind_of ::Google::Cloud::Dlp::V2::CreateJobTriggerRequest, request
      assert_equal "hello world", request.parent
      assert_equal Gapic::Protobuf.coerce({}, to: ::Google::Cloud::Dlp::V2::JobTrigger), request.job_trigger
      assert_equal "hello world", request.trigger_id
      assert_equal "hello world", request.location_id
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, create_job_trigger_client_stub do
      # Create client
      client = ::Google::Cloud::Dlp::V2::DlpService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.create_job_trigger({ parent: parent, job_trigger: job_trigger, trigger_id: trigger_id, location_id: location_id }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.create_job_trigger parent: parent, job_trigger: job_trigger, trigger_id: trigger_id, location_id: location_id do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.create_job_trigger ::Google::Cloud::Dlp::V2::CreateJobTriggerRequest.new(parent: parent, job_trigger: job_trigger, trigger_id: trigger_id, location_id: location_id) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.create_job_trigger({ parent: parent, job_trigger: job_trigger, trigger_id: trigger_id, location_id: location_id }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.create_job_trigger ::Google::Cloud::Dlp::V2::CreateJobTriggerRequest.new(parent: parent, job_trigger: job_trigger, trigger_id: trigger_id, location_id: location_id), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, create_job_trigger_client_stub.call_rpc_count
    end
  end

  def test_update_job_trigger
    # Create GRPC objects.
    grpc_response = ::Google::Cloud::Dlp::V2::JobTrigger.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    name = "hello world"
    job_trigger = {}
    update_mask = {}

    update_job_trigger_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :update_job_trigger, name
      assert_kind_of ::Google::Cloud::Dlp::V2::UpdateJobTriggerRequest, request
      assert_equal "hello world", request.name
      assert_equal Gapic::Protobuf.coerce({}, to: ::Google::Cloud::Dlp::V2::JobTrigger), request.job_trigger
      assert_equal Gapic::Protobuf.coerce({}, to: ::Google::Protobuf::FieldMask), request.update_mask
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, update_job_trigger_client_stub do
      # Create client
      client = ::Google::Cloud::Dlp::V2::DlpService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.update_job_trigger({ name: name, job_trigger: job_trigger, update_mask: update_mask }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.update_job_trigger name: name, job_trigger: job_trigger, update_mask: update_mask do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.update_job_trigger ::Google::Cloud::Dlp::V2::UpdateJobTriggerRequest.new(name: name, job_trigger: job_trigger, update_mask: update_mask) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.update_job_trigger({ name: name, job_trigger: job_trigger, update_mask: update_mask }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.update_job_trigger ::Google::Cloud::Dlp::V2::UpdateJobTriggerRequest.new(name: name, job_trigger: job_trigger, update_mask: update_mask), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, update_job_trigger_client_stub.call_rpc_count
    end
  end

  def test_hybrid_inspect_job_trigger
    # Create GRPC objects.
    grpc_response = ::Google::Cloud::Dlp::V2::HybridInspectResponse.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    name = "hello world"
    hybrid_item = {}

    hybrid_inspect_job_trigger_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :hybrid_inspect_job_trigger, name
      assert_kind_of ::Google::Cloud::Dlp::V2::HybridInspectJobTriggerRequest, request
      assert_equal "hello world", request.name
      assert_equal Gapic::Protobuf.coerce({}, to: ::Google::Cloud::Dlp::V2::HybridContentItem), request.hybrid_item
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, hybrid_inspect_job_trigger_client_stub do
      # Create client
      client = ::Google::Cloud::Dlp::V2::DlpService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.hybrid_inspect_job_trigger({ name: name, hybrid_item: hybrid_item }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.hybrid_inspect_job_trigger name: name, hybrid_item: hybrid_item do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.hybrid_inspect_job_trigger ::Google::Cloud::Dlp::V2::HybridInspectJobTriggerRequest.new(name: name, hybrid_item: hybrid_item) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.hybrid_inspect_job_trigger({ name: name, hybrid_item: hybrid_item }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.hybrid_inspect_job_trigger ::Google::Cloud::Dlp::V2::HybridInspectJobTriggerRequest.new(name: name, hybrid_item: hybrid_item), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, hybrid_inspect_job_trigger_client_stub.call_rpc_count
    end
  end

  def test_get_job_trigger
    # Create GRPC objects.
    grpc_response = ::Google::Cloud::Dlp::V2::JobTrigger.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    name = "hello world"

    get_job_trigger_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :get_job_trigger, name
      assert_kind_of ::Google::Cloud::Dlp::V2::GetJobTriggerRequest, request
      assert_equal "hello world", request.name
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, get_job_trigger_client_stub do
      # Create client
      client = ::Google::Cloud::Dlp::V2::DlpService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.get_job_trigger({ name: name }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.get_job_trigger name: name do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.get_job_trigger ::Google::Cloud::Dlp::V2::GetJobTriggerRequest.new(name: name) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.get_job_trigger({ name: name }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.get_job_trigger ::Google::Cloud::Dlp::V2::GetJobTriggerRequest.new(name: name), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, get_job_trigger_client_stub.call_rpc_count
    end
  end

  def test_list_job_triggers
    # Create GRPC objects.
    grpc_response = ::Google::Cloud::Dlp::V2::ListJobTriggersResponse.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    parent = "hello world"
    page_token = "hello world"
    page_size = 42
    order_by = "hello world"
    filter = "hello world"
    location_id = "hello world"

    list_job_triggers_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :list_job_triggers, name
      assert_kind_of ::Google::Cloud::Dlp::V2::ListJobTriggersRequest, request
      assert_equal "hello world", request.parent
      assert_equal "hello world", request.page_token
      assert_equal 42, request.page_size
      assert_equal "hello world", request.order_by
      assert_equal "hello world", request.filter
      assert_equal "hello world", request.location_id
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, list_job_triggers_client_stub do
      # Create client
      client = ::Google::Cloud::Dlp::V2::DlpService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.list_job_triggers({ parent: parent, page_token: page_token, page_size: page_size, order_by: order_by, filter: filter, location_id: location_id }) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.list_job_triggers parent: parent, page_token: page_token, page_size: page_size, order_by: order_by, filter: filter, location_id: location_id do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.list_job_triggers ::Google::Cloud::Dlp::V2::ListJobTriggersRequest.new(parent: parent, page_token: page_token, page_size: page_size, order_by: order_by, filter: filter, location_id: location_id) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.list_job_triggers({ parent: parent, page_token: page_token, page_size: page_size, order_by: order_by, filter: filter, location_id: location_id }, grpc_options) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.list_job_triggers ::Google::Cloud::Dlp::V2::ListJobTriggersRequest.new(parent: parent, page_token: page_token, page_size: page_size, order_by: order_by, filter: filter, location_id: location_id), grpc_options do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, list_job_triggers_client_stub.call_rpc_count
    end
  end

  def test_delete_job_trigger
    # Create GRPC objects.
    grpc_response = ::Google::Protobuf::Empty.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    name = "hello world"

    delete_job_trigger_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :delete_job_trigger, name
      assert_kind_of ::Google::Cloud::Dlp::V2::DeleteJobTriggerRequest, request
      assert_equal "hello world", request.name
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, delete_job_trigger_client_stub do
      # Create client
      client = ::Google::Cloud::Dlp::V2::DlpService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.delete_job_trigger({ name: name }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.delete_job_trigger name: name do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.delete_job_trigger ::Google::Cloud::Dlp::V2::DeleteJobTriggerRequest.new(name: name) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.delete_job_trigger({ name: name }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.delete_job_trigger ::Google::Cloud::Dlp::V2::DeleteJobTriggerRequest.new(name: name), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, delete_job_trigger_client_stub.call_rpc_count
    end
  end

  def test_activate_job_trigger
    # Create GRPC objects.
    grpc_response = ::Google::Cloud::Dlp::V2::DlpJob.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    name = "hello world"

    activate_job_trigger_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :activate_job_trigger, name
      assert_kind_of ::Google::Cloud::Dlp::V2::ActivateJobTriggerRequest, request
      assert_equal "hello world", request.name
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, activate_job_trigger_client_stub do
      # Create client
      client = ::Google::Cloud::Dlp::V2::DlpService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.activate_job_trigger({ name: name }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.activate_job_trigger name: name do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.activate_job_trigger ::Google::Cloud::Dlp::V2::ActivateJobTriggerRequest.new(name: name) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.activate_job_trigger({ name: name }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.activate_job_trigger ::Google::Cloud::Dlp::V2::ActivateJobTriggerRequest.new(name: name), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, activate_job_trigger_client_stub.call_rpc_count
    end
  end

  def test_create_dlp_job
    # Create GRPC objects.
    grpc_response = ::Google::Cloud::Dlp::V2::DlpJob.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    parent = "hello world"

    create_dlp_job_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :create_dlp_job, name
      assert_kind_of ::Google::Cloud::Dlp::V2::CreateDlpJobRequest, request
      assert_equal "hello world", request.parent
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, create_dlp_job_client_stub do
      # Create client
      client = ::Google::Cloud::Dlp::V2::DlpService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.create_dlp_job({ parent: parent }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.create_dlp_job parent: parent do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.create_dlp_job ::Google::Cloud::Dlp::V2::CreateDlpJobRequest.new(parent: parent) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.create_dlp_job({ parent: parent }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.create_dlp_job ::Google::Cloud::Dlp::V2::CreateDlpJobRequest.new(parent: parent), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, create_dlp_job_client_stub.call_rpc_count
    end
  end

  def test_list_dlp_jobs
    # Create GRPC objects.
    grpc_response = ::Google::Cloud::Dlp::V2::ListDlpJobsResponse.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    parent = "hello world"
    filter = "hello world"
    page_size = 42
    page_token = "hello world"
    type = :DLP_JOB_TYPE_UNSPECIFIED
    order_by = "hello world"
    location_id = "hello world"

    list_dlp_jobs_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :list_dlp_jobs, name
      assert_kind_of ::Google::Cloud::Dlp::V2::ListDlpJobsRequest, request
      assert_equal "hello world", request.parent
      assert_equal "hello world", request.filter
      assert_equal 42, request.page_size
      assert_equal "hello world", request.page_token
      assert_equal :DLP_JOB_TYPE_UNSPECIFIED, request.type
      assert_equal "hello world", request.order_by
      assert_equal "hello world", request.location_id
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, list_dlp_jobs_client_stub do
      # Create client
      client = ::Google::Cloud::Dlp::V2::DlpService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.list_dlp_jobs({ parent: parent, filter: filter, page_size: page_size, page_token: page_token, type: type, order_by: order_by, location_id: location_id }) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.list_dlp_jobs parent: parent, filter: filter, page_size: page_size, page_token: page_token, type: type, order_by: order_by, location_id: location_id do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.list_dlp_jobs ::Google::Cloud::Dlp::V2::ListDlpJobsRequest.new(parent: parent, filter: filter, page_size: page_size, page_token: page_token, type: type, order_by: order_by, location_id: location_id) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.list_dlp_jobs({ parent: parent, filter: filter, page_size: page_size, page_token: page_token, type: type, order_by: order_by, location_id: location_id }, grpc_options) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.list_dlp_jobs ::Google::Cloud::Dlp::V2::ListDlpJobsRequest.new(parent: parent, filter: filter, page_size: page_size, page_token: page_token, type: type, order_by: order_by, location_id: location_id), grpc_options do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, list_dlp_jobs_client_stub.call_rpc_count
    end
  end

  def test_get_dlp_job
    # Create GRPC objects.
    grpc_response = ::Google::Cloud::Dlp::V2::DlpJob.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    name = "hello world"

    get_dlp_job_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :get_dlp_job, name
      assert_kind_of ::Google::Cloud::Dlp::V2::GetDlpJobRequest, request
      assert_equal "hello world", request.name
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, get_dlp_job_client_stub do
      # Create client
      client = ::Google::Cloud::Dlp::V2::DlpService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.get_dlp_job({ name: name }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.get_dlp_job name: name do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.get_dlp_job ::Google::Cloud::Dlp::V2::GetDlpJobRequest.new(name: name) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.get_dlp_job({ name: name }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.get_dlp_job ::Google::Cloud::Dlp::V2::GetDlpJobRequest.new(name: name), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, get_dlp_job_client_stub.call_rpc_count
    end
  end

  def test_delete_dlp_job
    # Create GRPC objects.
    grpc_response = ::Google::Protobuf::Empty.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    name = "hello world"

    delete_dlp_job_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :delete_dlp_job, name
      assert_kind_of ::Google::Cloud::Dlp::V2::DeleteDlpJobRequest, request
      assert_equal "hello world", request.name
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, delete_dlp_job_client_stub do
      # Create client
      client = ::Google::Cloud::Dlp::V2::DlpService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.delete_dlp_job({ name: name }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.delete_dlp_job name: name do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.delete_dlp_job ::Google::Cloud::Dlp::V2::DeleteDlpJobRequest.new(name: name) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.delete_dlp_job({ name: name }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.delete_dlp_job ::Google::Cloud::Dlp::V2::DeleteDlpJobRequest.new(name: name), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, delete_dlp_job_client_stub.call_rpc_count
    end
  end

  def test_cancel_dlp_job
    # Create GRPC objects.
    grpc_response = ::Google::Protobuf::Empty.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    name = "hello world"

    cancel_dlp_job_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :cancel_dlp_job, name
      assert_kind_of ::Google::Cloud::Dlp::V2::CancelDlpJobRequest, request
      assert_equal "hello world", request.name
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, cancel_dlp_job_client_stub do
      # Create client
      client = ::Google::Cloud::Dlp::V2::DlpService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.cancel_dlp_job({ name: name }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.cancel_dlp_job name: name do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.cancel_dlp_job ::Google::Cloud::Dlp::V2::CancelDlpJobRequest.new(name: name) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.cancel_dlp_job({ name: name }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.cancel_dlp_job ::Google::Cloud::Dlp::V2::CancelDlpJobRequest.new(name: name), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, cancel_dlp_job_client_stub.call_rpc_count
    end
  end

  def test_create_stored_info_type
    # Create GRPC objects.
    grpc_response = ::Google::Cloud::Dlp::V2::StoredInfoType.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    parent = "hello world"
    config = {}
    stored_info_type_id = "hello world"
    location_id = "hello world"

    create_stored_info_type_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :create_stored_info_type, name
      assert_kind_of ::Google::Cloud::Dlp::V2::CreateStoredInfoTypeRequest, request
      assert_equal "hello world", request.parent
      assert_equal Gapic::Protobuf.coerce({}, to: ::Google::Cloud::Dlp::V2::StoredInfoTypeConfig), request.config
      assert_equal "hello world", request.stored_info_type_id
      assert_equal "hello world", request.location_id
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, create_stored_info_type_client_stub do
      # Create client
      client = ::Google::Cloud::Dlp::V2::DlpService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.create_stored_info_type({ parent: parent, config: config, stored_info_type_id: stored_info_type_id, location_id: location_id }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.create_stored_info_type parent: parent, config: config, stored_info_type_id: stored_info_type_id, location_id: location_id do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.create_stored_info_type ::Google::Cloud::Dlp::V2::CreateStoredInfoTypeRequest.new(parent: parent, config: config, stored_info_type_id: stored_info_type_id, location_id: location_id) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.create_stored_info_type({ parent: parent, config: config, stored_info_type_id: stored_info_type_id, location_id: location_id }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.create_stored_info_type ::Google::Cloud::Dlp::V2::CreateStoredInfoTypeRequest.new(parent: parent, config: config, stored_info_type_id: stored_info_type_id, location_id: location_id), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, create_stored_info_type_client_stub.call_rpc_count
    end
  end

  def test_update_stored_info_type
    # Create GRPC objects.
    grpc_response = ::Google::Cloud::Dlp::V2::StoredInfoType.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    name = "hello world"
    config = {}
    update_mask = {}

    update_stored_info_type_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :update_stored_info_type, name
      assert_kind_of ::Google::Cloud::Dlp::V2::UpdateStoredInfoTypeRequest, request
      assert_equal "hello world", request.name
      assert_equal Gapic::Protobuf.coerce({}, to: ::Google::Cloud::Dlp::V2::StoredInfoTypeConfig), request.config
      assert_equal Gapic::Protobuf.coerce({}, to: ::Google::Protobuf::FieldMask), request.update_mask
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, update_stored_info_type_client_stub do
      # Create client
      client = ::Google::Cloud::Dlp::V2::DlpService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.update_stored_info_type({ name: name, config: config, update_mask: update_mask }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.update_stored_info_type name: name, config: config, update_mask: update_mask do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.update_stored_info_type ::Google::Cloud::Dlp::V2::UpdateStoredInfoTypeRequest.new(name: name, config: config, update_mask: update_mask) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.update_stored_info_type({ name: name, config: config, update_mask: update_mask }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.update_stored_info_type ::Google::Cloud::Dlp::V2::UpdateStoredInfoTypeRequest.new(name: name, config: config, update_mask: update_mask), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, update_stored_info_type_client_stub.call_rpc_count
    end
  end

  def test_get_stored_info_type
    # Create GRPC objects.
    grpc_response = ::Google::Cloud::Dlp::V2::StoredInfoType.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    name = "hello world"

    get_stored_info_type_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :get_stored_info_type, name
      assert_kind_of ::Google::Cloud::Dlp::V2::GetStoredInfoTypeRequest, request
      assert_equal "hello world", request.name
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, get_stored_info_type_client_stub do
      # Create client
      client = ::Google::Cloud::Dlp::V2::DlpService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.get_stored_info_type({ name: name }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.get_stored_info_type name: name do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.get_stored_info_type ::Google::Cloud::Dlp::V2::GetStoredInfoTypeRequest.new(name: name) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.get_stored_info_type({ name: name }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.get_stored_info_type ::Google::Cloud::Dlp::V2::GetStoredInfoTypeRequest.new(name: name), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, get_stored_info_type_client_stub.call_rpc_count
    end
  end

  def test_list_stored_info_types
    # Create GRPC objects.
    grpc_response = ::Google::Cloud::Dlp::V2::ListStoredInfoTypesResponse.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    parent = "hello world"
    page_token = "hello world"
    page_size = 42
    order_by = "hello world"
    location_id = "hello world"

    list_stored_info_types_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :list_stored_info_types, name
      assert_kind_of ::Google::Cloud::Dlp::V2::ListStoredInfoTypesRequest, request
      assert_equal "hello world", request.parent
      assert_equal "hello world", request.page_token
      assert_equal 42, request.page_size
      assert_equal "hello world", request.order_by
      assert_equal "hello world", request.location_id
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, list_stored_info_types_client_stub do
      # Create client
      client = ::Google::Cloud::Dlp::V2::DlpService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.list_stored_info_types({ parent: parent, page_token: page_token, page_size: page_size, order_by: order_by, location_id: location_id }) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.list_stored_info_types parent: parent, page_token: page_token, page_size: page_size, order_by: order_by, location_id: location_id do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.list_stored_info_types ::Google::Cloud::Dlp::V2::ListStoredInfoTypesRequest.new(parent: parent, page_token: page_token, page_size: page_size, order_by: order_by, location_id: location_id) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.list_stored_info_types({ parent: parent, page_token: page_token, page_size: page_size, order_by: order_by, location_id: location_id }, grpc_options) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.list_stored_info_types ::Google::Cloud::Dlp::V2::ListStoredInfoTypesRequest.new(parent: parent, page_token: page_token, page_size: page_size, order_by: order_by, location_id: location_id), grpc_options do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, list_stored_info_types_client_stub.call_rpc_count
    end
  end

  def test_delete_stored_info_type
    # Create GRPC objects.
    grpc_response = ::Google::Protobuf::Empty.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    name = "hello world"

    delete_stored_info_type_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :delete_stored_info_type, name
      assert_kind_of ::Google::Cloud::Dlp::V2::DeleteStoredInfoTypeRequest, request
      assert_equal "hello world", request.name
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, delete_stored_info_type_client_stub do
      # Create client
      client = ::Google::Cloud::Dlp::V2::DlpService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.delete_stored_info_type({ name: name }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.delete_stored_info_type name: name do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.delete_stored_info_type ::Google::Cloud::Dlp::V2::DeleteStoredInfoTypeRequest.new(name: name) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.delete_stored_info_type({ name: name }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.delete_stored_info_type ::Google::Cloud::Dlp::V2::DeleteStoredInfoTypeRequest.new(name: name), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, delete_stored_info_type_client_stub.call_rpc_count
    end
  end

  def test_hybrid_inspect_dlp_job
    # Create GRPC objects.
    grpc_response = ::Google::Cloud::Dlp::V2::HybridInspectResponse.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    name = "hello world"
    hybrid_item = {}

    hybrid_inspect_dlp_job_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :hybrid_inspect_dlp_job, name
      assert_kind_of ::Google::Cloud::Dlp::V2::HybridInspectDlpJobRequest, request
      assert_equal "hello world", request.name
      assert_equal Gapic::Protobuf.coerce({}, to: ::Google::Cloud::Dlp::V2::HybridContentItem), request.hybrid_item
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, hybrid_inspect_dlp_job_client_stub do
      # Create client
      client = ::Google::Cloud::Dlp::V2::DlpService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.hybrid_inspect_dlp_job({ name: name, hybrid_item: hybrid_item }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.hybrid_inspect_dlp_job name: name, hybrid_item: hybrid_item do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.hybrid_inspect_dlp_job ::Google::Cloud::Dlp::V2::HybridInspectDlpJobRequest.new(name: name, hybrid_item: hybrid_item) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.hybrid_inspect_dlp_job({ name: name, hybrid_item: hybrid_item }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.hybrid_inspect_dlp_job ::Google::Cloud::Dlp::V2::HybridInspectDlpJobRequest.new(name: name, hybrid_item: hybrid_item), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, hybrid_inspect_dlp_job_client_stub.call_rpc_count
    end
  end

  def test_finish_dlp_job
    # Create GRPC objects.
    grpc_response = ::Google::Protobuf::Empty.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    name = "hello world"

    finish_dlp_job_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :finish_dlp_job, name
      assert_kind_of ::Google::Cloud::Dlp::V2::FinishDlpJobRequest, request
      assert_equal "hello world", request.name
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, finish_dlp_job_client_stub do
      # Create client
      client = ::Google::Cloud::Dlp::V2::DlpService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.finish_dlp_job({ name: name }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.finish_dlp_job name: name do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.finish_dlp_job ::Google::Cloud::Dlp::V2::FinishDlpJobRequest.new(name: name) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.finish_dlp_job({ name: name }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.finish_dlp_job ::Google::Cloud::Dlp::V2::FinishDlpJobRequest.new(name: name), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, finish_dlp_job_client_stub.call_rpc_count
    end
  end

  def test_configure
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure

    client = block_config = config = nil
    Gapic::ServiceStub.stub :new, nil do
      client = ::Google::Cloud::Dlp::V2::DlpService::Client.new do |config|
        config.credentials = grpc_channel
      end
    end

    config = client.configure do |c|
      block_config = c
    end

    assert_same block_config, config
    assert_kind_of ::Google::Cloud::Dlp::V2::DlpService::Client::Configuration, config
  end
end
