class ItemCollectsController < ApplicationController
  before_action :set_item_collect
  def index; end

  def add_promise
    @promise_form = Builder::PromiseForm.new
    @promise_form.item_collect_id = @item_collect.id
  end

  def save_promise
    @promise_form = Builder::PromiseForm.new(promise_form_params)
    if @promise_form.save
      flash[:info] = 'Gracias por tus promesas, son de gran ayuda!'
      redirect_to items_project_path(@item_collect.project)
    else
      render 'add_promise'
    end
  end

  private
  def set_item_collect
    @item_collect = ItemCollect.find params[:id]
  end

  def promise_form_params
    params.require(:builder_promise_form).permit(:id, :name, :last_name, :ci, :phone, :amount, :item_collect_id)
  end
end
