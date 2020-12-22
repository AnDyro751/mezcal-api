# frozen_string_literal: true
class ApplicationController < ActionController::Base
  before_action :show_session

  def show_session
    @order = Spree::Order.find_by(guest_token: 'VtbcDEmPyDlh0qpZ4t7mVQ')
  end
end
