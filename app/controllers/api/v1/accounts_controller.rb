module Api
  module V1
    class AccountsController < ApplicationController

      def index
        @accounts = Account.all
        render json: AccountSerializer.new(@accounts).serializable_hash{[:data][:attributes]}
      end

      def show
        @account = Account.find(params[:id])
        followers = Follower.where(following: @account.id, request_status: 'accepted').select(:account_id)
        render json: AccountSerializer.new(Account.where(id:followers)).serializable_hash{[:data][:attributes]}

      end

    end
  end
end
