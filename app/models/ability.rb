class Ability
  include CanCan::Ability

  def initialize(user)
    return if user.nil?

    @user = user
    registered_user
  end

  def registered_user
    can :manage, Expense
  end

  private

  attr_reader :user
end
