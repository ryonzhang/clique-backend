require 'geocoder'
class SessionsController < ApplicationController
  before_action :set_session, only: [:show, :update, :destroy,:link,:delink,:feedback,:get_feedback]
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
    @sessions = current_user.sessions
    json_response(@sessions)
  end

  #admin partner
  def create
    classinfo = Classinfo.find(params[:classinfo_id])
    return json_response({reason:'the institution does not belong to the user'}, :internal_server_error) unless current_user.institutions.include?(classinfo.institution)
    @session=classinfo.sessions.create!(session_params)
    json_response(@session, :created)
  end

  #partner
  def list
    @sessions = current_user.institutions.map{|i| i.classinfos.map{|c| c.sessions}.flatten}.flatten
    if @sessions
      json_data = @sessions.map do |c|
        c.as_json(include: {classinfo:{include: :institution}})
      end
    end
    json_response(json_data || [])
  end


  def upcoming
    if params[:user_id]!=nil then
      @sessions = User.find(params[:user_id]).sessions.select{|c| c.time>Time.now}.sort! { |x, y| x.time <=> y.time }.reverse!
    else
      @sessions = current_user.sessions.select{|c| c.time>Time.now}.sort! { |x, y| x.time <=> y.time }.reverse!
    end
    if @sessions
      json_data = @sessions.map do |c|
        c.as_json(include: {classinfo:{include: :institution}})
      end
    end
    json_response(json_data || [])
  end

  def completed
    if params[:user_id]!=nil then
      @sessions = User.find(params[:user_id]).sessions.select{|c| c.time<Time.now}.sort! { |x, y| x.time <=> y.time }.reverse!
    else
      @sessions = current_user.sessions.select{|c| c.time<Time.now}.sort! { |x, y| x.time <=> y.time }.reverse!
    end
    if @sessions
      json_data = @sessions.map do |c|
        c.as_json(include: {classinfo:{include: :institution}})
      end
    end
    json_response(json_data || [])
  end

  def find_by_tag
    @sessions = Tag.find_by_name(params[:tag]).try(:classinfos).map{|c| c.sessions}.flatten
    if @sessions
      json_data = @sessions.map do |c|
        c.as_json(include: {classinfo:{include: :institution}})
      end
    end
    json_response(json_data || [])
  end

  def new
    @sessions = Tag.find_by_name('new').try(:classinfos).select{|c| c.time>Time.now}.sort! { |x, y| x.time <=> y.time } unless Tag.find_by_name('new')==nil
    if @sessions
      json_data = @sessions.map do |c|
        c.as_json(include: {classinfo:{include: :institution}})
      end
    end
    json_response(sessions:json_data || [],upcoming_count: current_user.sessions.select{|c| c.time>Time.now}.count,completed_count:current_user.sessions.select{|c| c.time<Time.now}.count)
  end

  def link
    usersession = Usersession.where(user:current_user,session:@session).count >0 || Usersession.create!(user:current_user,session:@session)
    json_response(usersession, :accepted)
  end

  def delink
    Usersession.where(user:current_user,session:@session).delete_all
    json_response({}, :accepted)
  end

  def date
    @sessions= Session.where(classinfo_id:Classinfo.where(["credit > :lower_credit and credit < :upper_credit and level>= :min_level and level<= :max_level and not (min_age>= :max_age or max_age<= :min_age )",{lower_credit:params[:min_credit],upper_credit:params[:max_credit],min_level:params[:min_level],max_level:params[:max_level],min_age:params[:min_age],max_age:params[:max_age]}])).where(time: params[:date].to_time.change(
        hour: params[:min_hour],
        min: 0,
        sec: 0,
        )..params[:date].to_time.change(
        hour: params[:max_hour],
        min: 0,
        sec: 0,
        )).select do |s|
      Geocoder::Calculations.distance_between([s.classinfo.institution.latitude,s.classinfo.institution.longitude],[params[:latitude].to_f,params[:longitude].to_f],{units: :km}) <= params[:max_distance].to_f && Geocoder::Calculations.distance_between([s.classinfo.institution.latitude,s.classinfo.institution.longitude],[params[:latitude].to_f,params[:longitude].to_f],{units: :km}) >= params[:min_distance].to_f
    end.sort! { |x, y| x.time <=> y.time }
    @sessions = @sessions.select{|s| s.classinfo.name.downcase.include?(params[:class_name].downcase)} unless params[:class_name].to_s.strip.empty?
    if @sessions
      json_data = @sessions.map do |c|
        c.as_json(include: {classinfo:{include: :institution}})
      end
    end
    json_response(json_data || [])
  end



  def show
    usersession= Usersession.find_by(user:current_user,session:@session)
    feedback = Feedback.find_by(user:current_user,session:@session)
    if usersession != nil
      if usersession.attended then
        if feedback!=nil then
          status = 'feedbacked'
        else
          status = 'attended'
        end
      elsif Time.now > @session.time.to_time then
        status = 'missed'
      else
        status = 'booked'
      end
    else
      status = 'open'
    end

    json_response({session:@session.as_json(include: {classinfo:{include: [:institution,:tags,:categories]}}),status:status})
  end

  def update
    success=@session.update!(session_params)
    json_response(success, :accepted)
  end

  def destroy
    @session.destroy
    head :no_content
  end

  def feedback
    feedback = Feedback.find_by(user:current_user,session:@session)
    if feedback!=nil
      feedback.update(comment:params[:comment],star_num:params[:star_num])
      return json_response({},:accepted)
    else
      feedback = Feedback.create(user:current_user,session:@session,classinfo:@session.classinfo,institution:@session.classinfo.institution,comment:params[:comment],star_num:params[:star_num])
      return json_response(feedback,:created)
    end
  end

  def get_feedback
    feedback = Feedback.find_by(user:current_user,session:@session)
    json_response(feedback||{},:accepted)
  end

  private

  def session_params
    params.permit(:id,:time,:duration_in_min,:vacancies)
  end


  def set_session
    @session = Session.find(params[:id])
  end
end
