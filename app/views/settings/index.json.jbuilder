json.set! :data do
  json.array! @settings do |setting|
    json.partial! 'settings/setting', setting: setting
    json.url "#{link_to 'Edit', edit_setting_path(setting), data: {remote: true}, class: 'btn btn-primary'}"
  end
end