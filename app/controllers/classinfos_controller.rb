require 'geocoder'
class ClassinfosController < ApplicationController
  before_action :set_classinfo, only: [:show, :update, :destroy,:link,:delink]
  #admin
  def all
    @classes = Classinfo.all
    if @classes
      json_data = @classes.map do |c|
        c.as_json(include: :institution)
      end
    end
    json_response(json_data || [])
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
    if @classes
      json_data = @classes.map do |c|
        c.as_json(include: :institution)
      end
    end
    json_response(json_data || [])
  end

  def upcoming
    @classes = current_user.classinfos.select{|c| c.time>Time.now}.sort! { |x, y| x.time <=> y.time }
    if @classes
      json_data = @classes.map do |c|
        c.as_json(include: :institution)
      end
    end
    json_response(json_data || [])
  end

  def completed
    @classes = current_user.classinfos.select{|c| c.time<Time.now}.sort! { |x, y| x.time <=> y.time }.reverse!
    if @classes
      json_data = @classes.map do |c|
        c.as_json(include: :institution)
      end
    end
    json_response(json_data || [])
  end

  def find_by_tag
    @classes = Tag.find_by_name(params[:tag]).try(:classinfos)
    if @classes
      json_data = @classes.map do |c|
        c.as_json(include: [:institution,:tags])
      end
    end
    json_response(json_data || [])
  end

  def new
    @classes = Tag.find_by_name('new').try(:classinfos).select{|c| c.time>Time.now}.sort! { |x, y| x.time <=> y.time }
    if @classes
      json_data = @classes.map do |c|
        c.as_json(include: :institution)
      end
    end
    json_response(json_data || [])
  end

  def link
    userclass = Userclass.where(user:current_user,classinfo:@classinfo).count >0 || Userclass.create!(user:current_user,classinfo:@classinfo)
    json_response(userclass, :created)
  end

  def delink
    Userclass.where(user:current_user,classinfo:@classinfo).delete_all
    json_response({}, :accepted)
  end

  def filter
    @classes=Classinfo.where(["credit > :lower_credit and credit < :upper_credit",{lower_credit:params[:lower_credit],upper_credit:params[:upper_credit]}]).select do |c|
      Geocoder::Calculations.distance_between(c.institution.latitude,c.institution.longitude,params[:latitude].to_f,params[:longitude].to_f,{units: :km}) <= params[:distance].to_f*1000
    end
    if @classes
      json_data = @classes.map do |c|
        c.as_json(include: :institution)
      end
    end
    json_response(json_data || [])
  end

  def show
    json_response(@classinfo.as_json(include: [:institution,:tags,:categories]))
  end

  def update
    @classinfo.update!(classinfo_params)
    head :no_content
  end

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
