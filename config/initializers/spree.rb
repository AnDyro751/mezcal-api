# Configure Solidus Preferences
# See http://docs.solidus.io/Spree/AppConfiguration.html for details

Spree.config do |config|
  # Core:

  # Default currency for new sites
  config.currency = "MXN"
  config.default_country_iso = "MEX"

  # from address for transactional emails
  config.mails_from = "store@example.com"

  # Use combined first and last name attribute in HTML views and API responses
  config.use_combined_first_and_last_name_in_address = true

  # Use legacy Spree::Order state machine
  config.use_legacy_order_state_machine = false

  # Use the legacy address' state validation logic
  config.use_legacy_address_state_validator = false

  # Uncomment to stop tracking inventory levels in the application
  # config.track_inventory_levels = false

  # When set, product caches are only invalidated when they fall below or rise
  # above the inventory_cache_threshold that is set. Default is to invalidate cache on
  # any inventory changes.
  # config.inventory_cache_threshold = 3

  # Enable Paperclip adapter for attachments on images and taxons
  config.image_attachment_module = 'Spree::Image::PaperclipAttachment'
  config.taxon_attachment_module = 'Spree::Taxon::PaperclipAttachment'

  # Disable legacy Solidus custom CanCanCan actions aliases
  config.use_custom_cancancan_actions = false

  # Defaults

  # Set this configuration to `true` to raise an exception when
  # an order is populated with a line item with a mismatching
  # currency. The `false` value will just add a validation error
  # and will be the only behavior accepted in future versions.
  # See https://github.com/solidusio/solidus/pull/3456 for more info.
  config.raise_with_invalid_currency = false

  # Set this configuration to false to always redirect the user to
  # /unauthorized when needed, without trying to redirect them to
  # their previous location first.
  config.redirect_back_on_unauthorized = true

  # Set this configuration to `true` to allow promotions
  # with no associated actions to be considered active for use by customers.
  # See https://github.com/solidusio/solidus/pull/3749 for more info.
  config.consider_actionless_promotion_active = false

  # Set this configuration to `false` to avoid running validations when
  # updating an order. Be careful since you can end up having inconsistent
  # data in your database turning it on.
  # See https://github.com/solidusio/solidus/pull/3645 for more info.
  config.run_order_validations_on_order_updater = true

  # Permission Sets:

  # Uncomment and customize the following line to add custom permission sets
  # to a custom users role:
  # config.roles.assign_permissions :role_name, ['Spree::PermissionSets::CustomPermissionSet']


  # Frontend:

  # Custom logo for the frontend
  # config.logo = "logo/solidus.svg"

  # Template to use when rendering layout
  # config.layout = "spree/layouts/spree_application"


  # Admin:

  # Custom logo for the admin
  # config.admin_interface_logo = "logo/solidus.svg"

  # Gateway credentials can be configured statically here and referenced from
  # the admin. They can also be fully configured from the admin.
  #
  # Please note that you need to use the solidus_stripe gem to have
  # Stripe working: https://github.com/solidusio-contrib/solidus_stripe
  #
  # config.static_model_preferences.add(
  #   Spree::PaymentMethod::StripeCreditCard,
  #   'stripe_env_credentials',
  #   secret_key: ENV['STRIPE_SECRET_KEY'],
  #   publishable_key: ENV['STRIPE_PUBLISHABLE_KEY'],
  #   server: Rails.env.production? ? 'production' : 'test',
  #   test_mode: !Rails.env.production?
  # )
end

Spree::Frontend::Config.configure do |config|
  config.locale = 'en'
end

Spree::Backend::Config.configure do |config|
  config.locale = 'en'

  # Uncomment and change the following configuration if you want to add
  # a new menu item:
  #
  # config.menu_items << config.class::MenuItem.new(
  #   [:section],
  #   'icon-name',
  #   url: 'https://solidus.io/'
  # )
end

Spree::Api::Config.configure do |config|
  config.requires_authentication = true
end

Spree.user_class = "Spree::LegacyUser"

# Rules for avoiding to store the current path into session for redirects
# When at least one rule is matched, the request path will not be stored
# in session.
# You can add your custom rules by uncommenting this line and changing
# the class name:
#
# Spree::UserLastUrlStorer.rules << 'Spree::UserLastUrlStorer::Rules::AuthenticationRule'
