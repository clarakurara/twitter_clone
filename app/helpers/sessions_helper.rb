module SessionsHelper
    # Logs in the given user
    def log_in(user)
        session[:user_id] = user.id
    end

    # Returns the current logged-in user (if any)
    def current_user
        User.find_by(id: session[:user_id])
    end

    def current_user?(user)
        current_user == user
    end

    # Checks if the user is logged in or not
    def logged_in?
        !current_user.nil?
    end

    # Logs out the current user
    def log_out
        session.delete(:user_id)
    end
end