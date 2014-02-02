class Ability
  include CanCan::Ability

  def initialize(user)
    user.permissions.each do |permission|
      can permission.action.to_sym, permission.thing_type.constantize do |thing|
        # TODO: this could be wrong

        # The Ability class’s initialize method defines how can? and cannot? will act. In this example, 
        # you iterate over all the users’ permissions and use the can? method to say that a user can 
        # perform a specific function. Users who shouldn’t be able to perform that function won’t have 
        # an entry in the permissions table for it. This is the whitelist authorization described at 
        # the beginning of the chapter.

        thing.nil? ||
        permission.thing_id.nil? ||
        permission.thing_id == thing.id
      end
    end
  end

end
