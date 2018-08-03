class DashboardsController < ApplicationController
  
  def index
    @date = Date.today
    @begin = params[:begin].nil? ? (@date - 30.days) : params[:begin].to_date
    @end = params[:end].nil? ? @date : params[:end].to_date
    respond_to do |format|
      format.html
      format.json do
        @mail_data = Event.where(kind: 'daily').between_times(@begin, @end, field: :date)
      end
    end
  end

  def event_log
    @date = Date.today.to_time
    @section = params[:section].nil? ? "delivered" : params[:section]
    @begin = params[:end].nil? ? @date : params[:end].to_date
    @end = params[:begin].nil? ? (@date - 7.days) : params[:begin].to_date
    respond_to do |format|
      format.html
      format.json do
        @logs = EventLog.where(status: @section).between_times(@end, @begin + 1.days, field: :date).order(date: :desc)
      end
    end
  end

  def bounces_user
    respond_to do |format|
      format.html
      format.json do
        @data = Bounce.limit(100)
      end
    end
  end

end