# Copyright 2017 Google LLC
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

require "helper"

describe Google::Cloud::Firestore::Transaction, :get, :empty, :mock_firestore do
  let(:transaction_id) { "transaction123" }
  let(:transaction) { Google::Cloud::Firestore::Transaction.from_client firestore }
  let(:transaction_opt) do
    Google::Firestore::V1::TransactionOptions.new(
      read_write: Google::Firestore::V1::TransactionOptions::ReadWrite.new
    )
  end
  let(:read_time) { Time.now }
  let :query_results_enum do
    [
      Google::Firestore::V1::RunQueryResponse.new(transaction: transaction_id),
      Google::Firestore::V1::RunQueryResponse.new(
        read_time: Google::Cloud::Firestore::Convert.time_to_timestamp(read_time),
        document: Google::Firestore::V1::Document.new(
          name: "projects/#{project}/databases/(default)/documents/users/mike",
          fields: { "name" => Google::Firestore::V1::Value.new(string_value: "Mike") },
          create_time: Google::Cloud::Firestore::Convert.time_to_timestamp(read_time),
          update_time: Google::Cloud::Firestore::Convert.time_to_timestamp(read_time)
        )),
      Google::Firestore::V1::RunQueryResponse.new(
        read_time: Google::Cloud::Firestore::Convert.time_to_timestamp(read_time),
        document: Google::Firestore::V1::Document.new(
          name: "projects/#{project}/databases/(default)/documents/users/chris",
          fields: { "name" => Google::Firestore::V1::Value.new(string_value: "Chris") },
          create_time: Google::Cloud::Firestore::Convert.time_to_timestamp(read_time),
          update_time: Google::Cloud::Firestore::Convert.time_to_timestamp(read_time)
        ))
    ].to_enum
  end

  it "gets a document (doc ref)" do
    batch_get_resp_enum = [
      Google::Firestore::V1::BatchGetDocumentsResponse.new(
        transaction: transaction_id
      ),
      Google::Firestore::V1::BatchGetDocumentsResponse.new(
        read_time: Google::Cloud::Firestore::Convert.time_to_timestamp(read_time),
        found: Google::Firestore::V1::Document.new(
          name: "projects/#{project}/databases/(default)/documents/users/mike",
          fields: { "name" => Google::Firestore::V1::Value.new(string_value: "Mike") },
          create_time: Google::Cloud::Firestore::Convert.time_to_timestamp(read_time),
          update_time: Google::Cloud::Firestore::Convert.time_to_timestamp(read_time))
      )
    ].to_enum
    firestore_mock.expect :batch_get_documents, batch_get_resp_enum, ["projects/#{project}/databases/(default)", documents: ["projects/#{project}/databases/(default)/documents/users/mike"], mask: nil, new_transaction: transaction_opt, options: default_options]

    col = firestore.col :users
    _(col).must_be_kind_of Google::Cloud::Firestore::CollectionReference

    doc_ref = col.doc :mike
    _(doc_ref).must_be_kind_of Google::Cloud::Firestore::DocumentReference

    _(transaction.transaction_id).must_be :nil?

    doc = transaction.get doc_ref

    _(transaction.transaction_id).must_equal transaction_id

    _(doc).must_be_kind_of Google::Cloud::Firestore::DocumentSnapshot
    _(doc.document_id).must_equal doc_ref.document_id
    _(doc.document_path).must_equal doc_ref.document_path

    _(doc.parent).must_be_kind_of Google::Cloud::Firestore::CollectionReference
    _(doc.parent.collection_id).must_equal col.collection_id
    _(doc.parent.collection_path).must_equal col.collection_path

    _(doc).must_be :exists?
    _(doc.data).must_be_kind_of Hash
    _(doc.data).must_equal({ name: "Mike" })
    _(doc.created_at).must_equal read_time
    _(doc.updated_at).must_equal read_time
    _(doc.read_at).must_equal read_time
  end

  it "gets a document (string)" do
    batch_get_resp_enum = [
      Google::Firestore::V1::BatchGetDocumentsResponse.new(
        transaction: transaction_id
      ),
      Google::Firestore::V1::BatchGetDocumentsResponse.new(
        read_time: Google::Cloud::Firestore::Convert.time_to_timestamp(read_time),
        found: Google::Firestore::V1::Document.new(
          name: "projects/#{project}/databases/(default)/documents/users/mike",
          fields: { "name" => Google::Firestore::V1::Value.new(string_value: "Mike") },
          create_time: Google::Cloud::Firestore::Convert.time_to_timestamp(read_time),
          update_time: Google::Cloud::Firestore::Convert.time_to_timestamp(read_time))
      )
    ].to_enum
    firestore_mock.expect :batch_get_documents, batch_get_resp_enum, ["projects/#{project}/databases/(default)", documents: ["projects/#{project}/databases/(default)/documents/users/mike"], mask: nil, new_transaction: transaction_opt, options: default_options]

    doc_ref = firestore.doc "users/mike"
    _(doc_ref).must_be_kind_of Google::Cloud::Firestore::DocumentReference

    _(transaction.transaction_id).must_be :nil?

    doc = transaction.get "users/mike"

    _(transaction.transaction_id).must_equal transaction_id

    _(doc).must_be_kind_of Google::Cloud::Firestore::DocumentSnapshot
    _(doc.document_id).must_equal doc_ref.document_id
    _(doc.document_path).must_equal doc_ref.document_path

    _(doc.parent).must_be_kind_of Google::Cloud::Firestore::CollectionReference
    _(doc.parent.collection_id).must_equal doc_ref.parent.collection_id
    _(doc.parent.collection_path).must_equal doc_ref.parent.collection_path

    _(doc).must_be :exists?
    _(doc.data).must_be_kind_of Hash
    _(doc.data).must_equal({ name: "Mike" })
    _(doc.created_at).must_equal read_time
    _(doc.updated_at).must_equal read_time
    _(doc.read_at).must_equal read_time
  end

  it "gets a collection (ref)" do
    expected_query = Google::Firestore::V1::StructuredQuery.new(
      from: [Google::Firestore::V1::StructuredQuery::CollectionSelector.new(collection_id: "users", all_descendants: false)]
    )
    firestore_mock.expect :run_query, query_results_enum, ["projects/#{project}/databases/(default)/documents", structured_query: expected_query, new_transaction: transaction_opt, options: default_options]

    col = firestore.col :users
    results_enum = transaction.get col

    assert_results_enum results_enum
  end

  it "gets a collection (string)" do
    expected_query = Google::Firestore::V1::StructuredQuery.new(
      from: [Google::Firestore::V1::StructuredQuery::CollectionSelector.new(collection_id: "users", all_descendants: false)]
    )
    firestore_mock.expect :run_query, query_results_enum, ["projects/#{project}/databases/(default)/documents", structured_query: expected_query, new_transaction: transaction_opt, options: default_options]

    results_enum = transaction.get "users"

    assert_results_enum results_enum
  end

  it "gets a collection (symbol)" do
    expected_query = Google::Firestore::V1::StructuredQuery.new(
      from: [Google::Firestore::V1::StructuredQuery::CollectionSelector.new(collection_id: "users", all_descendants: false)]
    )
    firestore_mock.expect :run_query, query_results_enum, ["projects/#{project}/databases/(default)/documents", structured_query: expected_query, new_transaction: transaction_opt, options: default_options]

    results_enum = transaction.get :users

    assert_results_enum results_enum
  end

  it "gets a simple query" do
    expected_query = Google::Firestore::V1::StructuredQuery.new(
      select: Google::Firestore::V1::StructuredQuery::Projection.new(
        fields: [Google::Firestore::V1::StructuredQuery::FieldReference.new(field_path: "name")]),
      from: [Google::Firestore::V1::StructuredQuery::CollectionSelector.new(collection_id: "users", all_descendants: false)]
    )
    firestore_mock.expect :run_query, query_results_enum, ["projects/#{project}/databases/(default)/documents", structured_query: expected_query, new_transaction: transaction_opt, options: default_options]

    query = firestore.col(:users).select(:name)
    results_enum = transaction.get query

    assert_results_enum results_enum
  end

  it "gets a complex query" do
    expected_query = Google::Firestore::V1::StructuredQuery.new(
      select: Google::Firestore::V1::StructuredQuery::Projection.new(
        fields: [Google::Firestore::V1::StructuredQuery::FieldReference.new(field_path: "name")]),
      from: [Google::Firestore::V1::StructuredQuery::CollectionSelector.new(collection_id: "users", all_descendants: false)],
      offset: 3,
      limit: Google::Protobuf::Int32Value.new(value: 42),
      order_by: [
        Google::Firestore::V1::StructuredQuery::Order.new(
          field: Google::Firestore::V1::StructuredQuery::FieldReference.new(field_path: "name"),
          direction: :ASCENDING),
        Google::Firestore::V1::StructuredQuery::Order.new(
          field: Google::Firestore::V1::StructuredQuery::FieldReference.new(field_path: "__name__"),
          direction: :DESCENDING)],
      start_at: Google::Firestore::V1::Cursor.new(values: [Google::Cloud::Firestore::Convert.raw_to_value("foo")], before: false),
      end_at: Google::Firestore::V1::Cursor.new(values: [Google::Cloud::Firestore::Convert.raw_to_value("bar")], before: true)
    )
    firestore_mock.expect :run_query, query_results_enum, ["projects/#{project}/databases/(default)/documents", structured_query: expected_query, new_transaction: transaction_opt, options: default_options]

    query = firestore.col(:users).select(:name).offset(3).limit(42).order(:name).order(firestore.document_id, :desc).start_after(:foo).end_before(:bar)
    results_enum = transaction.get query

    assert_results_enum results_enum
  end

  def assert_results_enum enum
    _(enum).must_be_kind_of Enumerator

    results = enum.to_a
    _(results.count).must_equal 2

    results.each do |result|
      _(result).must_be_kind_of Google::Cloud::Firestore::DocumentSnapshot

      _(result.ref).must_be_kind_of Google::Cloud::Firestore::DocumentReference
      _(result.ref.client).must_equal firestore

      _(result.parent).must_be_kind_of Google::Cloud::Firestore::CollectionReference
      _(result.parent.collection_id).must_equal "users"
      _(result.parent.collection_path).must_equal "users"
      _(result.parent.path).must_equal "projects/projectID/databases/(default)/documents/users"
      _(result.parent.client).must_equal firestore
    end

    _(results.first.data).must_be_kind_of Hash
    _(results.first.data).must_equal({ name: "Mike" })
    _(results.first.created_at).must_equal read_time
    _(results.first.updated_at).must_equal read_time
    _(results.first.read_at).must_equal read_time

    _(results.last.data).must_be_kind_of Hash
    _(results.last.data).must_equal({ name: "Chris" })
    _(results.last.created_at).must_equal read_time
    _(results.last.updated_at).must_equal read_time
    _(results.last.read_at).must_equal read_time
  end
end
