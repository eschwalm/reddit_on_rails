class SubsController < ApplicationController
  before_action :is_moderator?, only: [:edit, :update]
  def new
    @sub = Sub.new
    render :new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user.id

    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def index
    @subs = Sub.all
    render :index
  end

  def show
    @sub = Sub.find(params[:id])
    render :show
  end

  def edit
    @sub = Sub.find(params[:id])
    render :edit
  end

  def update
    @sub = current_user.subs.find_by(id: params[:id])

    if @sub.update_attributes(sub_params)
      redirect_to sub_url
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  private

  def sub_params
    params.require(:sub).permit(:name, :description)
  end

  def is_moderator?
    return if current_user.subs.find_by(id: params[:id])
    render json: 'Forbidden', status: :forbidden
  end
end
