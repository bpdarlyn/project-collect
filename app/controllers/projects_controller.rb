class ProjectsController < ApplicationController
  before_action :options, only: [:options]

  def index
    @projects = Project.all.order(created_at: :desc)
  end

  def options; end

  private

  def set_project
    @project = Project.find params[:id]
  end
end
