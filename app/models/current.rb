class Current < ActiveSupport::CurrentAttributes
  attribute :user

  # Define a method to check if the user is logged in
  def user?(user)
    user == self.user
  end
end
