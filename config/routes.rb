ActionController::Routing::Routes.draw do |map|
  map.resource :nm_5500,
    :controller => 'fast_commands/nm_5500',
    :path_prefix => 'admin',
    :as => 'nm-5500',
    :only => :show
end
