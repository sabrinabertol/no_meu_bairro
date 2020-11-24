class DashboardController < ApplicationController
    before_action :authenticate_user!

    def index
        @news = NewsService.call
    end
end