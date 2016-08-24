module Api
  module V1
    class EventsController < BaseController

      respond_to :json
      def index
        count = params[:count].blank? ? 50 : params[:count]
        @events = Event.limit(count)

        render json: @events
      end
    end
  end
end
