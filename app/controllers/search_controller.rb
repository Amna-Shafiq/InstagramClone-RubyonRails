# frozen_string_literal: true

class SearchController < ApplicationController
  def index
    @search = Account.ransack(params[:q])
    @accounts = @search.result(distinct: true)
  end
end
