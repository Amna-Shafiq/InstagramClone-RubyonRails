# frozen_string_literal: true

class PostPolicy < ApplicationPolicy
  class Scope < Scope
  end

  def new?
    user
  end

  def create?
    record_not_nil? && record.account_id == user.id
  end

  def destroy?
    record_not_nil? && record.account_id == user.id
  end

  def edit?
    record.account_id == user.id
  end

  def update?
    user_exist? && record_not_nil? && record.account_id == user.id
  end

end
