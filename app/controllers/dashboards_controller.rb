class DashboardsController < ApplicationController
  
  def index
    respond_to do |format|
      format.html do
        total = Event.where(kind: "month")
        @delivered = total.map{ |x| x.delivered }.sum
        @bounce = total.map{ |x| x.failed }.sum
        @delay = total.map{ |x| x.suppressed }.sum
      end
      format.json do
        date = Date.today
        @mail_data = Event.where(kind: 'daily').between_times(date - 30.days, date, field: :date)
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
        # @result = @mg_client.get("#{@domain}/events",
        #   {event: @section, begin: @begin.to_date.rfc2822, end: @end.to_date.rfc2822, limit: 300}
        # )
        # @logs = JSON.parse(@result.body)['items']
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