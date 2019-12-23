class InstitutionsController < ApplicationController
  before_action :set_institution, only: [:show, :update, :destroy,:classes,:feedbacks]
  def show
    liked = current_user.institutions.include?(@institution)?true:false;
    json_response({institution:@institution.as_json(include: [:tags,:categories]),liked:liked})
  end

  def favorites
    if params[:user_id]==nil then
      return json_response(current_user.institutions,:accepted)
    else
      return json_response(User.find(params[:user_id]).institutions,:accepted)
    end
  end

  def classes
    json_data=Classinfo.where(time: params[:date].to_time.beginning_of_day..params[:date].to_time.end_of_day,institution_id: @institution.id).sort_by(&:time)
    json_response(json_data || [])
  end

  def fan
    fan = Favoriteinstitution.where(user:current_user,institution:@institution).count >0 || Favoriteinstitution.create!(user:current_user,institution:@institution)
    json_response(fan, :accepted)
  end

  def nearby
    @institutions=Institution.all.select do |i|
      Geocoder::Calculations.distance_between([i.latitude,i.longitude],[params[:latitude].to_f,params[:longitude].to_f],{units: :km}) <=  params[:max_distance].to_f && Geocoder::Calculations.distance_between([i.latitude,i.longitude],[params[:latitude].to_f,params[:longitude].to_f],{units: :km}) >= params[:min_distance].to_f
    end
    json_response(@institutions || [])
  end

  def defan
    fan = Favoriteinstitution.where(user:current_user,institution:@institution).count >0 || Favoriteinstitution.delete_all(user:current_user,institution:@institution)
    json_response(fan, :accepted)
  end

  def feedbacks
    feedbacks = @institution.feedbacks.limit(params[:limit]).offset(params[:offset])
    if feedbacks
      feedbacks = feedbacks.map do |c|
        c.as_json(include: :user)
      end
    end
    json_response(feedbacks, :accepted)
  end

  def set_institution
    @institution = Institution.find(params[:id])
  end
end
