class Admin::EndUsersController < ApplicationController
    def index
        @users = EndUser.with_deleted
    end
end
