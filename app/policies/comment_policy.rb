# frozen_string_literal: true

class CommentPolicy < ApplicationPolicy
  class Scope < Scope
  end

  def create?
    user_exist? && record.account_id == user.id
  end

  def destroy?
    user_exist? && record.account_id == user.id
  end

  def update?
    user_exist? && record.account_id == user.id
  end
end
