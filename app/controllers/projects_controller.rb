class ProjectsController < ApplicationController
  before_action :set_project, only: [:options, :items]

  def index
    @projects = Project.all.order(created_at: :desc)
  end

  def options; end

  def items
    @item_collects = @project.item_collects.order(total_amount: :desc)
    render 'item_collects/index'
  end

  private

  def set_project
    @project = Project.find params[:id]
  end
end
