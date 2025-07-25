class ProjectsController < ApplicationController
  before_action :set_project, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: %i[ index show ]

  # GET /projects or /projects.json
  def index
    @projects = Project.all.order(created_at: :desc)
  end

  # GET /projects/1 or /projects/1.json
  # def show
  #   if turbo_frame_request?
  #     render partial: "projects/modal", locals: { project: @project }
  #   else
  #     redirect_to projects_path, notice: "Unauthorized access"
  #   end
  # end
  def show
    Rails.logger.debug "Turbo Frame Request: #{turbo_frame_request?}"
    render partial: 'projects/modal', locals: { project: @project }
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects or /projects.json
  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to projects_path, notice: "Project was successfully created." }
        format.json { render :show, status: :created, location: projects_path }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1 or /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to projects_path, notice: "Project was successfully updated." }
        format.json { render :show, status: :ok, location: projects_path }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1 or /projects/1.json
  def destroy
    @project.destroy!

    respond_to do |format|
      format.html { redirect_to projects_path, status: :see_other, notice: "Project was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_project
    @project = Project.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def project_params
    params.require(:project).permit(:title, :project_type, :description, :image, :audio_file, :link)
  end
end
