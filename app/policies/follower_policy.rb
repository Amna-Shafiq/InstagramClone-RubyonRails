# frozen_string_literal: true

class FollowerPolicy < ApplicationPolicy
  class Scope < Scope
  end

  def new?
    user_exist? && record.account_id != record.following
  end

  def create?
    user_exist? && record.account_id != record.following
  end

  def destroy?
    user_exist? && record.account_id == user.id
  end
end
