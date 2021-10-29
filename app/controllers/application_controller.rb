class ApplicationController < ActionController::Base
    include SessionsHelper

    def logged_in_user
        unless logged_in?
            flash[:info] = "Please login first"
            redirect_to login_url
        end
    end
end
