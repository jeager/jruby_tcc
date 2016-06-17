class ExecutionsController < ApplicationController
  before_action :set_execution, only: [:show, :edit, :update, :destroy]


  # GET /executions/1
  # GET /executions/1.json
  def show
  end

  # GET /executions/new
  def new
    @execution = Execution.new
    @project = Project.find_by_id(params[:project_id])
    @description = Utils.get_description "Filter Method"
    @method = "Filter Method"
  end

  # POST /executions
  # POST /executions.json
  def create
    @project = Project.find_by_id(params[:project_id])
    @execution = Execution.new(execution_params)
    @execution.project = @project
    @execution.status = "Pending"
    @execution.timespent = DateTime.now.to_i
    dataset = MlMethods.new.open_dataset(@execution.project.attachment_url)
    attribute = dataset.attribute(@execution.class_name)
    save = true
    if(!attribute.nil?)
      dataset.setClass(attribute)
    else
      save = false
    end
    respond_to do |format|
      if save
        if @execution.save
          MlMethods.new.create_thread @execution
          flash[:notice] = 'Execution was successfully created.'
          format.html { redirect_to [@project,@execution]}
          format.json { render :show, status: :created, location: @execution }
        else
          flash[:warning] = 'Houveram erros durante a criação da execução.'
          format.html { render :new }
          format.json { render json: @execution.errors, status: :unprocessable_entity }
        end
      else
        flash[:warning] = 'Houveram erros durante a criação da execução.'
        @execution.errors.add(:class_name, "Classe não encontrada.")
          format.html { @description = Utils.get_description "Filter Method"
                        @method = "Filter Method"
                        render :new }
          format.json { render json: @execution.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /executions/1
  # PATCH/PUT /executions/1.json
  def update
    respond_to do |format|
      if @execution.update(execution_params)
        flash[:notice] = 'Execução não atualizada'
        format.html { redirect_to [@execution.project,@execution]}
        format.json { render :show, status: :ok, location: @execution }
      else
        flash[:warning] = 'Ocorreram erros'
        format.html { render :edit }
        format.json { render json: @execution.errors, status: :unprocessable_entity }
      end
    end
  end

  def set_method_description
    @description = Utils.get_description params[:execution][:method]
    @method = params[:execution][:method]
    respond_to do |format|
      format.js{}
    end
  end

  # DELETE /executions/1
  # DELETE /executions/1.json
  def destroy
    @execution.destroy
    flash[:notice] = 'Execução removida com sucesso' 
    respond_to do |format|
      format.html { redirect_to project_executions_url}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_execution
      @execution = Execution.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def execution_params
      params.require(:execution).permit(:method, :class_name)
    end
end
