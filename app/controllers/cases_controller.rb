class CasesController < ApplicationController

  prepend_before_action :require_no_authorization!, only: [:heartbeat]

  def show
    @case = Case.find(params[:id])
    @user = current_user
    authorize(@case)
    render json: { data: @case.serialized }
  end

  def index
    @cases = CaseSearch.new(search_params.merge(scope: policy_scope(Case)))
              .results
              .order(params[:sort_priority].presence || {created_at: :asc})
    render json: { data: @cases.map(&:serialized) }
  end

  def create
    @case = Case.new( case_params.merge(user_id: current_user.id) )
    authorize(@case)
    if @case.save
      render json: { data: @case.serialized }, status: 200
    else
      render json: { data: @case.serialized, errors: @case.errors }, status: 422
    end
  end

  def update
    @case = Case.find(params[:id])
    authorize(@case)
    if @case.update_attributes(case_params)
      render json: { data: @case.serialized }, status: 200
    else
      render json: { data: @case.serialized, errors: @case.errors }, status: 422
    end    
  end

  def destroy
    @case = Case.find(params[:id])
    authorize(@case)
    if @case.destroy
      render json: { data: @case.serialized }, status: 200
    else
      render json: { data: @case.serialized, errors: @case.errors, flash: { type: "error", message: "No pudo eliminarse el caso" } }, status: 422
    end
  end

  private

    def case_params
      params[:case].permit(:title, :expedient, :date, :avatar_cache, :status)
    end

    def search_params
      params[:search].presence || {}
    end

end
