class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :update, :destroy]
  #admin
  def all
    @cats = Category.all
    json_response(@cats)
  end

  #consumer
  def index
    @cats = current_user.classinfos.map(&:categories).flatten + current_user.institutions.map(&:categories).flatten
    json_response(@cats)
  end

  #admin partner
  def create
    @cat=Category.create!(category_params)
    json_response(@cat, :created)
  end

  #partner
  def list
    @classes = current_user.institutions.map(&:classinfos).flatten
    json_response(@classes)
  end

  # GET /todos/:id
  def show
    json_response(@classinfo)
  end

  # PUT /todos/:id
  def update
    @classinfo.update!(classinfo_params)
    head :no_content
  end

  # DELETE /todos/:id
  def destroy
    @classinfo.destroy
    head :no_content
  end

  private

  def category_params
    params.permit(:id,:time,:duration_in_min,:name,:level,:general_info,:preparation_info,:arrival_ahead_in_min,:additional_info,:vacancies,
                  :is_available,:bookable_before,:bookable_after)
  end


  def set_category
    @cat = Category.find(params[:id])
  end
end
