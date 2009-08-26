module FastCommands
  module Device
    NM5500_GATEWAY_NAME = 'xirgo-wired'
    def self.included(model)
      model.send(:include, NamedScopes)
    end

    module NamedScopes
      def self.included(model)
        model.class_eval do
          named_scope :nm5500_devices, :conditions => ['gateway_name = ?',  FastCommands::Device::NM5500_GATEWAY_NAME]
        end
      end
    end
  end
end
