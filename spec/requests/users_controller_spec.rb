require 'rails_helper'

RSpec.describe UsersController, type: :request do
  include_context "request context"
  
  describe "#show" do
    let(:user) { create(:user) }
    
    context "when the user is not logged in" do
      it "returns an unauthorized json" do
        get("/api/users/#{user.id}", headers: request_headers)
        expect(response.status).to eq(401)
      end
    end

    context "when the user is logged in" do
      include_context "user logged in"
      let(:auth_token) { Authenticator.new(email: user.email, password: user.password).generate_token }
      it "returns the user attributes" do
        get("/api/users/#{user.id}", headers: request_headers)
        expect(response.status).to eq(200)
        expect(response_body[:data][:first_name]).to eq(user.first_name)
        expect(response_body[:data][:last_name]).to eq(user.last_name)
        expect(response_body[:data][:email]).to eq(user.email) 
      end
    end
  end

  describe "#update" do
    let(:old_name) { 'John' }
    let(:new_name) { 'Oliver' }
    let(:user) { create(:user, first_name: old_name) }

    context "when the user is not logged in" do
      it "returns an unauthorized json" do
        put("/api/users/#{user.id}", params:{user: {}}.to_json, headers: request_headers)
        expect(response.status).to eq(401)
      end
    end

    context "when the user is logged in" do
      
      include_context "user logged in"
      let(:auth_token) { Authenticator.new(email: user.email, password: user.password).generate_token }
      
      it "returns the user attributes" do
        put("/api/users/#{user.id}", params: {user: {first_name: new_name}}.to_json, headers: request_headers)
        expect(response.status).to eq(200)
        user.reload
        expect(user.first_name).to eq(new_name)
      end

      context "and the update is invalid" do
        let(:new_name) { nil }
        it "returns a json error if the update is invalid" do
          put("/api/users/#{user.id}", params: {user: {first_name: new_name}}.to_json, headers: request_headers)
          expect(response.status).to eq(422)
          user.reload
          expect(user.first_name).to eq(old_name)        
        end        
      end
    end
  end

  describe "#update_password" do
    let(:old_password) { 'old12345678' }
    let(:new_password) { 'new12345678' }
    let(:user) { create(:user, password: old_password) }

    context "when the user is not logged in" do
      it "returns an unauthorized json" do
        put("/api/users/#{user.id}", params:{user: {}}.to_json, headers: request_headers)
        expect(response.status).to eq(401)
      end
    end

    context "when the user is logged in" do
      
      include_context "user logged in"
      let(:auth_token) { Authenticator.new(email: user.email, password: user.password).generate_token }
      
      it "updates the password" do
        put("/api/users/update_password", params: {user: {password: new_password, password_confirmation: new_password}}.to_json, headers: request_headers)
        expect(response.status).to eq(200)
        user.reload
        expect(user.authenticate(new_password)).to be_truthy
      end
    end
  end

end