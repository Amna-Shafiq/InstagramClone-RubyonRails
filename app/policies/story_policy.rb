# frozen_string_literal: true

class StoryPolicy < ApplicationPolicy
  class Scope < Scope
  end

  def show_stories?
    user
  end

  def show?
    user
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
end
