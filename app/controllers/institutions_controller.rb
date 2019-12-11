class InstitutionsController < ApplicationController
  before_action :set_institution, only: [:show, :update, :destroy]
  def show
    json_response(@institution.as_json(include: [:tags,:categories]))
  end

  def set_institution
    @institution = Institution.find(params[:id])
  end
end
