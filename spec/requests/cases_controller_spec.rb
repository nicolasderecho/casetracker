require 'rails_helper'

RSpec.describe CasesController, type: :request do
  include_context "request context"

  describe "#index" do

    context "when the user is logged in" do
      include_context "user logged in"
      let(:user) { create(:user) }
      let(:auth_token) { Authenticator.new(email: user.email, password: user.password).generate_token }
      
      context "And there are no cases" do

        it "returns an empty list" do
          get("/api/cases", headers: request_headers)
          expect(response_body[:data].length).to eq(0)
        end
      end

      context "And there are cases" do
        let!(:first_case) { create(:case, user: user, title: "first one") }
        let!(:second_case) { create(:case, user: user, title: "second one") }

        it "returns the cases" do
          get("/api/cases", headers: request_headers)
          cases = response_body[:data] 
          expect(cases.length).to eq(2)
          expect(cases.any? { |a_case| a_case[:id] == first_case.id }).to eq(true)
          expect(cases.any? { |a_case| a_case[:id] == second_case.id }).to eq(true)
        end

      end

    end

  end

  describe "#show" do

    context "when the user is logged in" do
      include_context "user logged in"
      let(:user) { create(:user) }
      let(:auth_token) { Authenticator.new(email: user.email, password: user.password).generate_token }
      let!(:the_case) { create(:case, user: user, title: "a test case") }
      
      it "returns the case" do
        get("/api/cases/#{the_case.id}", headers: request_headers)
        json_case = response_body[:data]
        expect(json_case[:id]).to eq(the_case.id)
        expect(json_case[:title]).to eq(the_case.title)
        expect(json_case[:expedient]).to eq(the_case.expedient)
      end

    end

  end

  describe "#create" do

    context "when the user is logged in" do
      include_context "user logged in"
      let(:user) { create(:user) }
      let(:auth_token) { Authenticator.new(email: user.email, password: user.password).generate_token }
      let(:date_field) { 3.days.ago }
      let(:case_params) { {title: "My case", expedient: "1234556", date: date_field} }

      it "creates the case" do
        expect { post("/api/cases", params: case_params.to_json, headers: request_headers) }.to change { Case.count }.from(0).to(1)
        created_case = Case.where(title: case_params[:title], expedient: case_params[:expedient], date: [date_field.beginning_of_day..date_field.end_of_day])
        expect(created_case).to exist
        expect(response_body[:data][:title]).to eq(case_params[:title])
        expect(response_body[:data][:expedient]).to eq(case_params[:expedient])
      end

    end

  end

  describe "#update" do

    context "when the user is logged in" do
      include_context "user logged in"
      let(:user) { create(:user) }
      let(:auth_token) { Authenticator.new(email: user.email, password: user.password).generate_token }
      let(:old_title) { "Old case title" }
      let(:old_expedient) { "Z9876" }
      let!(:existing_case) { create(:case, user: user, title: old_title, expedient: old_expedient) }
      let(:new_title) { "updated case" }
      let(:new_expedient) { "1234556" }
      let(:case_params) { {title: new_title, expedient: new_expedient } }

      it "updates the case" do
        put("/api/cases/#{existing_case.id}", params: case_params.to_json, headers: request_headers)
        existing_case.reload
        expect(existing_case.title).to eq(new_title)
        expect(existing_case.expedient).to eq(new_expedient)
        expect(response_body[:data][:title]).to eq(new_title)
        expect(response_body[:data][:expedient]).to eq(new_expedient)
      end

    end

  end

  describe "#destroy" do

    context "when the user is logged in" do
      include_context "user logged in"
      let(:user) { create(:user) }
      let(:auth_token) { Authenticator.new(email: user.email, password: user.password).generate_token }
      let!(:existing_case) { create(:case, user: user) }

      it "deletes the case" do
        expect { delete("/api/cases/#{existing_case.id}", headers: request_headers) }.to change { Case.count }.from(1).to(0)
        expect(Case.find_by(id: existing_case.id)).to be_nil
        expect(response.status).to be(200)
        expect(response_body[:data][:title]).to eq(existing_case.title)
        expect(response_body[:data][:expedient]).to eq(existing_case.expedient)
      end

    end

  end

end