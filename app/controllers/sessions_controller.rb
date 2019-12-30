require 'geocoder'
class SessionsController < ApplicationController
  before_action :set_session, only: [:show, :update, :destroy,:link,:delink]
  #admin
  def all
    @sessions = Session.all
    if @sessions
      json_data = @sessions.map do |c|
        c.as_json(include: {classinfo:{include: :institution}})
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
    institution = Institution.find(params[:institution_id])
    return json_response({reason:'the institution does not belong to the user'}, :internal_server_error) unless current_user.institutions.include?(institution)
    @classinfo=institution.classinfos.create!(classinfo_params)
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

  def register
    unless current_user.institutions.map { |i| i.classinfos }.flatten.includes?(Classinfo.find(params[:class_id]))
      return json_response({},:internal_server_error)
    end
    Userclass.where(user:User.find(params[:user_id]),classinfo: Classinfo.find(params[:class_id])).update(attended:true)
    json_response({},:accepted)
  end

  def upcoming
    if params[:user_id]!=nil then
      @classes = User.find(params[:user_id]).classinfos.select{|c| c.time>Time.now}.sort! { |x, y| x.time <=> y.time }.reverse!
    else
      @classes = current_user.classinfos.select{|c| c.time>Time.now}.sort! { |x, y| x.time <=> y.time }.reverse!
    end
    if @classes
      json_data = @classes.map do |c|
        c.as_json(include: :institution)
      end
    end
    json_response(json_data || [])
  end

  def completed
    if params[:user_id]!=nil then
      @classes = User.find(params[:user_id]).classinfos.select{|c| c.time<Time.now}.sort! { |x, y| x.time <=> y.time }.reverse!
    else
      @classes = current_user.classinfos.select{|c| c.time<Time.now}.sort! { |x, y| x.time <=> y.time }.reverse!
    end
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
    @classes = Tag.find_by_name('new').try(:classinfos).select{|c| c.time>Time.now}.sort! { |x, y| x.time <=> y.time } unless Tag.find_by_name('new')==nil
    if @classes
      json_data = @classes.map do |c|
        c.as_json(include: :institution)
      end
    end
    json_response(classes:json_data || [],upcoming_count: current_user.classinfos.select{|c| c.time>Time.now}.count,completed_count:current_user.classinfos.select{|c| c.time<Time.now}.count)
  end

  def link
    userclass = Userclass.where(user:current_user,classinfo:@classinfo).count >0 || Userclass.create!(user:current_user,classinfo:@classinfo)
    json_response(userclass, :accepted)
  end

  def delink
    Userclass.where(user:current_user,classinfo:@classinfo).delete_all
    json_response({}, :accepted)
  end

  def date
    @classes=Classinfo.where(["credit > :lower_credit and credit < :upper_credit and level>= :min_level and level<= :max_level and not (min_age>= :max_age or max_age<= :min_age )",{lower_credit:params[:min_credit],upper_credit:params[:max_credit],min_level:params[:min_level],max_level:params[:max_level],min_age:params[:min_age],max_age:params[:max_age]}]).where(time: params[:date].to_time.change(
        hour: params[:min_hour],
        min: 0,
        sec: 0,
        )..params[:date].to_time.change(
        hour: params[:max_hour],
        min: 0,
        sec: 0,
        )).select do |c|
      Geocoder::Calculations.distance_between([c.institution.latitude,c.institution.longitude],[params[:latitude].to_f,params[:longitude].to_f],{units: :km}) <= params[:max_distance].to_f && Geocoder::Calculations.distance_between([c.institution.latitude,c.institution.longitude],[params[:latitude].to_f,params[:longitude].to_f],{units: :km}) >= params[:min_distance].to_f
    end.sort! { |x, y| x.time <=> y.time }
    @classes = @classes.select{|c| c.name.downcase.include?(params[:class_name].downcase)} unless params[:class_name].to_s.strip.empty?
    if @classes
      json_data = @classes.map do |c|
        c.as_json(include: :institution)
      end
    end
    json_response(json_data || [])
  end



  def show
    userclass= Userclass.find_by(user:current_user,classinfo:@classinfo)
    feedback = Feedback.find_by(user:current_user,classinfo:@classinfo)
    if userclass != nil
      if userclass.attended then
        if feedback!=nil then
          status = 'feedbacked'
        else
          status = 'attended'
        end
      elsif Time.now > @classinfo.time.to_time then
        status = 'missed'
      else
        status = 'booked'
      end
    else
      status = 'open'
    end

    json_response({classinfo:@classinfo.as_json(include: [:institution,:tags,:categories]),status:status})
  end

  def update
    success=@classinfo.update!(classinfo_params)
    json_response(success, :accepted)
  end

  def destroy
    @classinfo.destroy
    head :no_content
  end

  def feedback
    classinfo = Classinfo.find(params[:classinfo_id])
    feedback = Feedback.find_by(user:current_user,classinfo:classinfo)
    if feedback!=nil
      feedback.update(comment:params[:comment],star_num:params[:star_num])
      return json_response({},:accepted)
    else
      feedback = Feedback.create(user:current_user,classinfo:classinfo,institution:classinfo.institution,comment:params[:comment],star_num:params[:star_num])
      return json_response(feedback,:created)
    end
  end

  def get_feedback
    classinfo = Classinfo.find(params[:classinfo_id])
    feedback = Feedback.find_by(user:current_user,classinfo:classinfo)
    json_response(feedback||{},:accepted)
  end

  private

  def classinfo_params
    params.permit(:id,:time,:duration_in_min,:name,:level,:general_info,:preparation_info,:arrival_ahead_in_min,:additional_info,:vacancies,
                  :is_available,:bookable_before,:bookable_after)
  end


  def set_session
    @session = Session.find(params[:id])
  end
end
