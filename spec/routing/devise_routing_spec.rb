require "rails_helper"

RSpec.describe DeviseController, type: :routing do
  describe "devise auth routing" do

    it "routes to #new" do
      expect(get: "/users/sign_in").to route_to("devise/sessions#new")
    end

    it "routes to #create" do
      expect(post: "/users/sign_in").to route_to("devise/sessions#create")
    end    

    it "routes to registration#new" do
      expect(get: "/users/sign_up").to route_to("devise/registrations#new")
    end

    it "routes to registration#create" do
      expect(post: "/users").to route_to("devise/registrations#create")
    end

    it "routes to session#destroy (aka sign_out)" do
      expect(delete: "/users/sign_out").to route_to("devise/sessions#destroy")
    end
  end
end