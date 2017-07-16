require 'rails_helper'

RSpec.describe CommentsController, type: :request do
  include_context "request context"

  describe "#create" do

    context "when the user is logged in" do
      include_context "user logged in"
      let(:user) { create(:user) }
      let!(:case_document) { create(:case) }
      let(:auth_token) { Authenticator.new(email: user.email, password: user.password).generate_token }
      let(:comment_params) { { description: 'example comment', date: Time.zone.now.to_s, commentable_type: "Case", commentable_id: case_document.id} }

      context "and the params are valid" do
        it "creates the comment" do
          post("/api/comments", params: comment_params.to_json, headers: request_headers)
          expect(response.status).to eq(200)
          expect(response_body[:data][:description]).to eq('example comment')
        end
      end

    end

  end

  describe "#show" do

    context "when the user is logged in" do
      include_context "user logged in"
      let(:user) { create(:user) }
      let!(:comment) {create(:comment, user_id: user.id, description: 'example comment')}
      let(:auth_token) { Authenticator.new(email: user.email, password: user.password).generate_token }

      it "returns the comment attributes" do
        get("/api/comments/#{comment.id}", headers: request_headers)
        expect(response.status).to eq(200)
        expect(response_body[:data][:description]).to eq('example comment')
      end

    end

  end

end