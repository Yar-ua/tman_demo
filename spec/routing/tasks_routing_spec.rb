require "rails_helper"

RSpec.describe TasksController, type: :routing do
  describe "tasks routing" do

    it "routes to #update" do
      expect(put: "/projects/50/tasks/70").to route_to("tasks#update", project_id: '50',  id: '70')
    end

    it "routes to #destroy" do
      expect(delete: "/projects/50/tasks/70").to route_to("tasks#destroy", project_id: '50', id: '70')
    end

    it "routes to #up" do
      expect(put: "/projects/50/tasks/70/up").to route_to("tasks#up", project_id: '50', id: '70')
    end

    it "routes to #down" do
      expect(put: "/projects/50/tasks/70/down").to route_to("tasks#down", project_id: '50', id: '70')
    end

    it "routes to #done" do
      expect(put: "/projects/50/tasks/70/done").to route_to("tasks#done", project_id: '50', id: '70')
    end

    it "routes to #inprocess" do
      expect(put: "/projects/50/tasks/70/inprocess").to route_to("tasks#inprocess", project_id: '50', id: '70')
    end

  end
end