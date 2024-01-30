# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||=User.new

    if user.role == 'super_admin'
      can :manage, :all
    elsif user.role == 'admin' || 'collaborator'
      can [:read, :create, :update], Company, user_id: user.id
    else
      can :read, :all
    end
  end
end
