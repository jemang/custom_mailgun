class SettingsController < ApplicationController
  before_action :set_setting, only: [:show, :edit, :update, :destroy]

  # GET /settings
  # GET /settings.json
  def index
    @settings = Setting.all
  end

  # GET /settings/1
  # GET /settings/1.json
  def show
  end

  # GET /settings/new
  def new
    @setting = Setting.new
  end

  # GET /settings/1/edit
  def edit
  end

  # POST /settings
  # POST /settings.json
  def create
    @setting = Setting.new(setting_params)

    respond_to do |format|
      if @setting.save
        format.html { redirect_to settings_path, notice: 'Setting was successfully created.' }
        format.json { render :show, status: :created, location: @setting }
      else
        format.html { render :new }
        format.json { render json: @setting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /settings/1
  # PATCH/PUT /settings/1.json
  def update
    if params[:token]
      if current_user.valid_password?(params[:setting][:pin])
        session[:verified] = true
        session[:expired_at] = Time.now + 2.minutes 
        redirect_to settings_path
      else
        redirect_to settings_path, notice: "wrong password"
      end
    else
      respond_to do |format|
        if @setting.update(setting_params)
          format.html { redirect_to settings_path, notice: 'Setting was successfully updated.' }
          format.json { render :show, status: :ok, location: @setting }
        else
          format.html { render :edit }
          format.json { render json: @setting.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /settings/1
  # DELETE /settings/1.json
  def destroy
    @setting.destroy
    respond_to do |format|
      format.html { redirect_to settings_url, notice: 'Setting was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_setting
      @setting = Setting.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def setting_params
      params.require(:setting).permit(:domain, :api_key, :ip_address, :smtp_hostname, :smtp_login, :api_url, :default_password)
    end
end
