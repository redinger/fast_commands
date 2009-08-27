ActionController::Routing::Routes.draw do |map|
  map.with_options :path_prefix => 'admin' do |admin|
    admin.resource :nm_5500,
      :controller => 'fast_commands/nm_5500s',
      :as => 'nm-5500',
      :only => :show do |nm_5500|
        nm_5500.resources :devices,
          :controller => 'fast_commands/devices',
          :only => :index do |device|
            device.resources :commands,
              :controller => 'fast_commands/commands',
              :only => :index
        end
    end
  end
end