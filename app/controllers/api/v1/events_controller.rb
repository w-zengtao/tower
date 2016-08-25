module Api
  module V1
    class EventsController < BaseController

      respond_to :json
      def index
        count = params[:count].blank? ? 50 : params[:count]
        @events = Event.includes(:eventable).limit(count)

        render json: @events, each_serializer: EventSerializer, root: "events", adapter: :json
      end
    end
  end
end
