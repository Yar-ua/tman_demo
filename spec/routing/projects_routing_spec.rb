require "rails_helper"

RSpec.describe ProjectsController, type: :routing do
  describe "projects routing" do
    it "root route to #index" do
      expect(get: "/").to route_to("projects#index")
    end

    it "routes to #index" do
      expect(get: "/projects").to route_to("projects#index")
    end

    it "routes to #create" do
      expect(post: "/projects").to route_to("projects#create")
    end

    it "routes to #update" do
      expect(put: "/projects/50").to route_to("projects#update", id: '50')
    end

    it "routes to #destroy" do
      expect(delete: "/projects/50").to route_to("projects#destroy", id: '50')
    end

  end
end
