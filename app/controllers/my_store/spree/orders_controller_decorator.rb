module MyStore
  module Spree
    # MyStore::Spree::OrdersControllerDecoratorController
    module OrdersControllerDecorator
      # def self.prepended(base)
      # base.before_action :load_data, only: :some_action
      # end

      def some_action
        puts "--------!-#{@order}-!---#{@current_order}"
        render json: {hola: "demo"}
      end
    end
  end
end
::Spree::OrdersController.prepend MyStore::Spree::OrdersControllerDecorator if ::Spree::OrdersController.included_modules.exclude?(MyStore::Spree::OrdersControllerDecorator)