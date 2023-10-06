# frozen_string_literal: true

class AccountsController < ApplicationController
  before_action :set_user, only: [:show]

  def index
    @search = Account.ransack(params[:q])
    @accounts = @search.result(distinct: true)
    Account.where.not(id: current_account.id).find_in_batches do |users|
      @users = users
    end
  end

  def show
    authorize @account
    if @account.present?
      @posts = @account.posts
    else
      flash[:notice] = 'Account does not exist'
    end
  end

  def new
   end

  private

  def set_user
    if Account.exists?(id: params[:id])
      @account = Account.includes(:posts).find_by(id: params[:id])
    else
      flash[:notice] = 'Account does not exist'
    end
  end
end
