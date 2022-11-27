class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  private

  def error_messages(record)
    record.errors.full_messages.join('<br>').html_safe
  end
end
