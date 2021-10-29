class MicropostsController < ApplicationController
    before_action :logged_in_user, only: [:create, :destroy]
    def create
        @micropost = current_user.microposts.build(micropost_params)
        if @micropost.save
            flash[:success] = "Micropost created!"
        else
            flash[:danger] = "Please input content"
        end
        redirect_back(fallback_location: request.referer)
    end
    def destroy
        Micropost.find(params[:id]).destroy
        flash[:success] = "Successfully deleted!"
        redirect_back(fallback_location: request.referer)
    end
    private
    def micropost_params
        params.require(:micropost).permit(:content)
    end
end