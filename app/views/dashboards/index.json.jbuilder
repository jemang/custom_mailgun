
json.set! :data do
  json.array!(@mail_data) do |mail|
    json.date mail.date
    json.delivered mail.delivered
    json.suppressed mail.suppressed
    json.failed mail.failed
  end
end

json.set! :chart do 
  @data_delivered = {}
  @data_dropped = {}
  @data_suppressed = {}

  @mail_data.each do |mail|
    @data_delivered["#{mail.date}"] = mail.delivered
    @data_suppressed["#{mail.date}"] = mail.suppressed
    @data_dropped["#{mail.date}"] = mail.failed
  end
  
  mail_array = [{name: "Delivered", data: @data_delivered},
    {name: "Suppressed", data: @data_suppressed},
    {name: "Dropped", data: @data_dropped}]
  json.data mail_array
  json.t_del @mail_data.map{|x| x.delivered }.sum
  json.t_sup @mail_data.map{|x| x.suppressed }.sum
  json.t_fail @mail_data.map{|x| x.failed }.sum
  json.t_total @mail_data.map{|x| (x.delivered + x.failed + x.suppressed) }.sum
end