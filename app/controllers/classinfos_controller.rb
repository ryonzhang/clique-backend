require 'geocoder'
class ClassinfosController < ApplicationController
  before_action :set_classinfo, only: [:show, :update, :destroy]
  #admin
  def all
    @classes = Classinfo.all
    json_response(@classes)
  end

  #consumer
  def index
    @classes = current_user.classinfos
    json_response(@classes)
  end

  #admin partner
  def create
    @classinfo=Classinfo.create!(classinfo_params)
    json_response(@classinfo, :created)
  end

  #partner
  def list
    @classes = current_user.institutions.map{|i| i.classinfos}.flatten
    json_response(@classes)
  end

  def find_by_tag
    json_response(Tag.find_by_name(params[:tag]).classinfos)
  end


  def filter
    @classes=Classinfo.where(["credit > :lower_credit and credit < :upper_credit",{lower_credit:params[:lower_credit],upper_credit:params[:upper_credit]}]).select do |c|
      Geocoder::Calculations.distance_between(c.institution.latitude,c.institution.longitude,params[:latitude].to_f,params[:longitude].to_f,{units: :km}) <= params[:distance].to_f*1000
    end
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

  def classinfo_params
    params.permit(:id,:time,:duration_in_min,:name,:level,:general_info,:preparation_info,:arrival_ahead_in_min,:additional_info,:vacancies,
                  :is_available,:bookable_before,:bookable_after)
  end


  def set_classinfo
    @classinfo = Classinfo.find(params[:id])
  end
end
