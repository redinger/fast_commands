module FastCommands
  module Shoulda
    def should_deny_access
      should_redirect_to('home') { @controller.url_for(:controller => :home) }
    end
  end
end

class Test::Unit::TestCase #:nodoc:
 extend  FastCommands::Shoulda
end
