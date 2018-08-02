json.set! :data do
  json.array!(@data) do |data|
    json.date data.date
    json.stat data.status
    json.email data.email
  end
end