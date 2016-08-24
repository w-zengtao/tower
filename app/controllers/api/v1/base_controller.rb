module Api
  module V1
    class BaseController < ApplicationController
      protect_from_forgery with: :null_session
      before_action :verify_authtoken

      private
      def verify_authtoken
        #TODO
      end
    end
  end
end
