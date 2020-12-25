Rails.application.routes.draw do
  # This line mounts Solidus's routes at the root of your application.
  # This means, any requests to URLs such as /products, will go to Spree::ProductsController.
  # If you would like to change where this engine is mounted, simply change the :at option to something different.
  #
  # We ask that you don't use the :as option here, as Solidus relies on it being the default of "spree"
  mount Spree::Core::Engine, at: '/'
  Spree::Core::Engine.routes.draw do
    get "/sale" => "orders#some_action"
    get '/create_checkout' => 'orders#some_action'
  end

  # match "/graphql", to: "spree/graphql#execute", via: [:options]
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end
  mount SolidusPaypalCommercePlatform::Engine, at: '/solidus_paypal_commerce_platform'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
