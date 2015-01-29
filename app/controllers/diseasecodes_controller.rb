class DiseasecodesController < ApplicationController
  before_action :authenticate_hospitaladmin!
  before_action :set_diseasecode, only: [:show, :edit, :update, :destroy]

  respond_to :html, :json

  def index
    #@diseasecodes = Diseasecode.all
    @diseasecodes = current_hospitaladmin.diseasecodes.all
    respond_with(@diseasecodes)
  end

  def show
    respond_with(@diseasecode)
  end

  def new
    @diseasecode = Diseasecode.new
    respond_with(@diseasecode)
  end

  def edit
  end

  def create
    @diseasecode = Diseasecode.new(diseasecode_params)
    @diseasecode.hospitaladmin_id = current_hospitaladmin.id
    @diseasecode.save
    respond_with(@diseasecode)
  end

  def update
    @diseasecode.update(diseasecode_params)
    respond_with(@diseasecode)
  end

  def destroy
    @diseasecode.destroy
    respond_with(@diseasecode)
  end

  private
    def set_diseasecode
      @diseasecode = Diseasecode.find(params[:id])
    end

    def diseasecode_params
      params.require(:diseasecode).permit(:disease, :code, :description)
    end
end
