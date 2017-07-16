RSpec.shared_context "request context", :shared_context => :metadata do
  let(:response_body) { @response_body ||= JSON.load(response.body).with_indifferent_access }
  let(:json_header) { 'application/json' }
  let(:default_request_headers) { { CONTENT_TYPE: json_header, ACCEPT: json_header} }
  let(:request_headers) { default_request_headers }                                                              
end

RSpec.shared_context "user logged in", :shared_context => :metadata do
  let(:auth_token) { raise("Must define an auth_token variable to use in the login request") }
  let(:logged_in_headers) { default_request_headers.merge({ AUTHORIZATION: "Bearer #{auth_token}" }) }
  let(:request_headers) { logged_in_headers }
end