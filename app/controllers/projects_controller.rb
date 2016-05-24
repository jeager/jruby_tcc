class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  # GET /projects
  # GET /projects.json
  def index
    @projects = current_user.projects.paginate(:page => params[:page], :per_page => 5).order(created_at: :desc)
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @executions = @project.executions.paginate(:page => params[:page], :per_page => 5).order(created_at: :desc)
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)
    @project.user = current_user

    respond_to do |format|
      if @project.save
        flash[:notice] = 'Projeto criado com sucesso.'
        format.html { redirect_to @project}
        format.json { render :show, status: :created, location: @project }
      else
        flash[:warning] = 'Ocorreu um erro ao salvar'
        format.html { render :new}
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        flash[:notice] = 'Projeto atualizado com sucesso'
        format.html { redirect_to @project }
        format.json { render :show, status: :ok, location: @project }
      else
        flash[:warning] = 'Ocorreu um erro ao salvar'
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:name, :description, :attachment)
    end

end
