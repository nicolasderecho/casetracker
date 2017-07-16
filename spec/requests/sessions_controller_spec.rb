require 'rails_helper'

RSpec.describe SessionsController, type: :request do
  include_context "request context"

  let(:user_email) { 'example@gmail.com' }
  let(:user_password) { '12345678' }
  let!(:user) { create(:user, email: user_email, password: user_password) }

  describe "#create" do
    let(:params) { { user: {email: user_email, password: user_password} } }
    
    context "when the request has valid credentials" do

      it "returns the access token" do
        post("/api/sessions", params: params.to_json, headers: request_headers )
        expect(response.status).to eq(200)
        expect(response_body).to include(:auth_token)
      end

    end

  end

  describe "#destroy" do

    let(:params) { {} }

    context "when the user is logged in" do
      
      include_context "user logged in"

      let(:auth_token) { Authenticator.new(email: user_email, password: user_password).generate_token }

      it "correctly logs out" do
        delete("/api/sessions", params: params.to_json, headers: request_headers )
        expect(response.status).to eq(200)
      end
    end


  end


end
