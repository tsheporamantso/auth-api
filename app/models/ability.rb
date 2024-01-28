# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||=User.new

    if user.role == 'super_admin'
      can :manage, :all
    else
      can :read, :all
    end
  end
end
