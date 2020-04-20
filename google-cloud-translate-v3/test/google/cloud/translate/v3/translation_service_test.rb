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

require "google/cloud/translate/v3/translation_service_pb"
require "google/cloud/translate/v3/translation_service_services_pb"
require "google/cloud/translate/v3/translation_service"

class Google::Cloud::Translate::V3::TranslationService::ClientTest < Minitest::Test
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

  def test_translate_text
    # Create GRPC objects.
    grpc_response = Google::Cloud::Translate::V3::TranslateTextResponse.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    contents = ["hello world"]
    mime_type = "hello world"
    source_language_code = "hello world"
    target_language_code = "hello world"
    parent = "hello world"
    model = "hello world"
    glossary_config = {}
    labels = {}

    translate_text_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :translate_text, name
      assert_kind_of Google::Cloud::Translate::V3::TranslateTextRequest, request
      assert_equal ["hello world"], request.contents
      assert_equal "hello world", request.mime_type
      assert_equal "hello world", request.source_language_code
      assert_equal "hello world", request.target_language_code
      assert_equal "hello world", request.parent
      assert_equal "hello world", request.model
      assert_equal Gapic::Protobuf.coerce({}, to: Google::Cloud::Translate::V3::TranslateTextGlossaryConfig), request.glossary_config
      assert_equal({}, request.labels.to_h)
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, translate_text_client_stub do
      # Create client
      client = Google::Cloud::Translate::V3::TranslationService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.translate_text({ contents: contents, mime_type: mime_type, source_language_code: source_language_code, target_language_code: target_language_code, parent: parent, model: model, glossary_config: glossary_config, labels: labels }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.translate_text contents: contents, mime_type: mime_type, source_language_code: source_language_code, target_language_code: target_language_code, parent: parent, model: model, glossary_config: glossary_config, labels: labels do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.translate_text Google::Cloud::Translate::V3::TranslateTextRequest.new(contents: contents, mime_type: mime_type, source_language_code: source_language_code, target_language_code: target_language_code, parent: parent, model: model, glossary_config: glossary_config, labels: labels) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.translate_text({ contents: contents, mime_type: mime_type, source_language_code: source_language_code, target_language_code: target_language_code, parent: parent, model: model, glossary_config: glossary_config, labels: labels }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.translate_text Google::Cloud::Translate::V3::TranslateTextRequest.new(contents: contents, mime_type: mime_type, source_language_code: source_language_code, target_language_code: target_language_code, parent: parent, model: model, glossary_config: glossary_config, labels: labels), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, translate_text_client_stub.call_rpc_count
    end
  end

  def test_detect_language
    # Create GRPC objects.
    grpc_response = Google::Cloud::Translate::V3::DetectLanguageResponse.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    parent = "hello world"

    detect_language_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :detect_language, name
      assert_kind_of Google::Cloud::Translate::V3::DetectLanguageRequest, request
      assert_equal "hello world", request.parent
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, detect_language_client_stub do
      # Create client
      client = Google::Cloud::Translate::V3::TranslationService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.detect_language({ parent: parent }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.detect_language parent: parent do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.detect_language Google::Cloud::Translate::V3::DetectLanguageRequest.new(parent: parent) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.detect_language({ parent: parent }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.detect_language Google::Cloud::Translate::V3::DetectLanguageRequest.new(parent: parent), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, detect_language_client_stub.call_rpc_count
    end
  end

  def test_get_supported_languages
    # Create GRPC objects.
    grpc_response = Google::Cloud::Translate::V3::SupportedLanguages.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    parent = "hello world"
    display_language_code = "hello world"
    model = "hello world"

    get_supported_languages_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :get_supported_languages, name
      assert_kind_of Google::Cloud::Translate::V3::GetSupportedLanguagesRequest, request
      assert_equal "hello world", request.parent
      assert_equal "hello world", request.display_language_code
      assert_equal "hello world", request.model
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, get_supported_languages_client_stub do
      # Create client
      client = Google::Cloud::Translate::V3::TranslationService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.get_supported_languages({ parent: parent, display_language_code: display_language_code, model: model }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.get_supported_languages parent: parent, display_language_code: display_language_code, model: model do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.get_supported_languages Google::Cloud::Translate::V3::GetSupportedLanguagesRequest.new(parent: parent, display_language_code: display_language_code, model: model) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.get_supported_languages({ parent: parent, display_language_code: display_language_code, model: model }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.get_supported_languages Google::Cloud::Translate::V3::GetSupportedLanguagesRequest.new(parent: parent, display_language_code: display_language_code, model: model), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, get_supported_languages_client_stub.call_rpc_count
    end
  end

  def test_batch_translate_text
    # Create GRPC objects.
    grpc_response = Google::Longrunning::Operation.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    parent = "hello world"
    source_language_code = "hello world"
    target_language_codes = ["hello world"]
    models = {}
    input_configs = [{}]
    output_config = {}
    glossaries = {}
    labels = {}

    batch_translate_text_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :batch_translate_text, name
      assert_kind_of Google::Cloud::Translate::V3::BatchTranslateTextRequest, request
      assert_equal "hello world", request.parent
      assert_equal "hello world", request.source_language_code
      assert_equal ["hello world"], request.target_language_codes
      assert_equal({}, request.models.to_h)
      assert_kind_of Google::Cloud::Translate::V3::InputConfig, request.input_configs.first
      assert_equal Gapic::Protobuf.coerce({}, to: Google::Cloud::Translate::V3::OutputConfig), request.output_config
      assert_equal({}, request.glossaries.to_h)
      assert_equal({}, request.labels.to_h)
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, batch_translate_text_client_stub do
      # Create client
      client = Google::Cloud::Translate::V3::TranslationService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.batch_translate_text({ parent: parent, source_language_code: source_language_code, target_language_codes: target_language_codes, models: models, input_configs: input_configs, output_config: output_config, glossaries: glossaries, labels: labels }) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.batch_translate_text parent: parent, source_language_code: source_language_code, target_language_codes: target_language_codes, models: models, input_configs: input_configs, output_config: output_config, glossaries: glossaries, labels: labels do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.batch_translate_text Google::Cloud::Translate::V3::BatchTranslateTextRequest.new(parent: parent, source_language_code: source_language_code, target_language_codes: target_language_codes, models: models, input_configs: input_configs, output_config: output_config, glossaries: glossaries, labels: labels) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.batch_translate_text({ parent: parent, source_language_code: source_language_code, target_language_codes: target_language_codes, models: models, input_configs: input_configs, output_config: output_config, glossaries: glossaries, labels: labels }, grpc_options) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.batch_translate_text Google::Cloud::Translate::V3::BatchTranslateTextRequest.new(parent: parent, source_language_code: source_language_code, target_language_codes: target_language_codes, models: models, input_configs: input_configs, output_config: output_config, glossaries: glossaries, labels: labels), grpc_options do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, batch_translate_text_client_stub.call_rpc_count
    end
  end

  def test_create_glossary
    # Create GRPC objects.
    grpc_response = Google::Longrunning::Operation.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    parent = "hello world"
    glossary = {}

    create_glossary_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :create_glossary, name
      assert_kind_of Google::Cloud::Translate::V3::CreateGlossaryRequest, request
      assert_equal "hello world", request.parent
      assert_equal Gapic::Protobuf.coerce({}, to: Google::Cloud::Translate::V3::Glossary), request.glossary
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, create_glossary_client_stub do
      # Create client
      client = Google::Cloud::Translate::V3::TranslationService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.create_glossary({ parent: parent, glossary: glossary }) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.create_glossary parent: parent, glossary: glossary do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.create_glossary Google::Cloud::Translate::V3::CreateGlossaryRequest.new(parent: parent, glossary: glossary) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.create_glossary({ parent: parent, glossary: glossary }, grpc_options) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.create_glossary Google::Cloud::Translate::V3::CreateGlossaryRequest.new(parent: parent, glossary: glossary), grpc_options do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, create_glossary_client_stub.call_rpc_count
    end
  end

  def test_list_glossaries
    # Create GRPC objects.
    grpc_response = Google::Cloud::Translate::V3::ListGlossariesResponse.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    parent = "hello world"
    page_size = 42
    page_token = "hello world"
    filter = "hello world"

    list_glossaries_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :list_glossaries, name
      assert_kind_of Google::Cloud::Translate::V3::ListGlossariesRequest, request
      assert_equal "hello world", request.parent
      assert_equal 42, request.page_size
      assert_equal "hello world", request.page_token
      assert_equal "hello world", request.filter
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, list_glossaries_client_stub do
      # Create client
      client = Google::Cloud::Translate::V3::TranslationService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.list_glossaries({ parent: parent, page_size: page_size, page_token: page_token, filter: filter }) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.list_glossaries parent: parent, page_size: page_size, page_token: page_token, filter: filter do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.list_glossaries Google::Cloud::Translate::V3::ListGlossariesRequest.new(parent: parent, page_size: page_size, page_token: page_token, filter: filter) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.list_glossaries({ parent: parent, page_size: page_size, page_token: page_token, filter: filter }, grpc_options) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.list_glossaries Google::Cloud::Translate::V3::ListGlossariesRequest.new(parent: parent, page_size: page_size, page_token: page_token, filter: filter), grpc_options do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, list_glossaries_client_stub.call_rpc_count
    end
  end

  def test_get_glossary
    # Create GRPC objects.
    grpc_response = Google::Cloud::Translate::V3::Glossary.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    name = "hello world"

    get_glossary_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :get_glossary, name
      assert_kind_of Google::Cloud::Translate::V3::GetGlossaryRequest, request
      assert_equal "hello world", request.name
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, get_glossary_client_stub do
      # Create client
      client = Google::Cloud::Translate::V3::TranslationService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.get_glossary({ name: name }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.get_glossary name: name do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.get_glossary Google::Cloud::Translate::V3::GetGlossaryRequest.new(name: name) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.get_glossary({ name: name }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.get_glossary Google::Cloud::Translate::V3::GetGlossaryRequest.new(name: name), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, get_glossary_client_stub.call_rpc_count
    end
  end

  def test_delete_glossary
    # Create GRPC objects.
    grpc_response = Google::Longrunning::Operation.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    name = "hello world"

    delete_glossary_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :delete_glossary, name
      assert_kind_of Google::Cloud::Translate::V3::DeleteGlossaryRequest, request
      assert_equal "hello world", request.name
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, delete_glossary_client_stub do
      # Create client
      client = Google::Cloud::Translate::V3::TranslationService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.delete_glossary({ name: name }) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.delete_glossary name: name do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.delete_glossary Google::Cloud::Translate::V3::DeleteGlossaryRequest.new(name: name) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.delete_glossary({ name: name }, grpc_options) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.delete_glossary Google::Cloud::Translate::V3::DeleteGlossaryRequest.new(name: name), grpc_options do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, delete_glossary_client_stub.call_rpc_count
    end
  end
end