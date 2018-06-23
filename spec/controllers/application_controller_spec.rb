require "rails_helper"

RSpec.describe ApiController, type: :controller do
  # create test user
  let!(:user) { create(:user) }
  # set headers for authorization
  let(:cookie) { { '_ga_stnwlf' => token_generator(user.id) } }
  let(:invalid_cookie) { { '_ga_stnwlf' => nil } }

  describe "#authorize_request" do
    context "when auth token is passed" do
      before { allow(request).to receive(:cookies).and_return(cookie) }

      # private method authorize_request returns current user
      it "sets the current user" do
        expect(subject.instance_eval { authorize_request }).to eq(user)
      end
    end

    context "when auth token is not passed" do
      before do
        allow(request).to receive(:cookies).and_return(invalid_cookie)
      end

      it "raises MissingToken error" do
        expect { subject.instance_eval { authorize_request } }.
            to raise_error(ExceptionHandler::MissingToken, /Missing token/)
      end
    end
  end
end