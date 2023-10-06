# frozen_string_literal: true

class AccountPolicy < ApplicationPolicy
  class Scope < Scope
  end

  def new?
    user
  end

  def create?
    user_exist?
  end

  def show?
    user_exist? && record_not_nil?
  end

  def index?
    user_exist? && record_not_nil? && user.following?(record.account_id)
  end

  def destroy?
    record.account_id == user.id
  end

  def edit?
    record.account_id == user.id
  end

  def update?
    record.account_id == user.id
  end
end
