module AuthorizationHelpers
  def define_permission!(user, action, thing)
    Permission.create!(user: user,
                       action: action,
                       thing: thing)
  end

  def check_permission_box(action, thing)
    check "permissions_#{thing.id}_#{action}"
  end
end

RSpec.configure do |c|
  c.include AuthorizationHelpers
end