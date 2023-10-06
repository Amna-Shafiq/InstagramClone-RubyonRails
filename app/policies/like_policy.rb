# frozen_string_literal: true

class LikePolicy < ApplicationPolicy
  class Scope < Scope
  end

  def new?
    user
  end

  def create?
    user_exist? && user.followers.find_by(following: record.post.account_id) || record.account.public_account? || user.id == record.post.account_id
  end

  def destroy?
    user_exist? && record.account_id == user.id
  end
end
