class Tweet
  include ActiveModel::Model
  include Referenceable::InstanceMethods
  extend Referenceable::ClassMethods

  attr_accessor :body, :user_id

  @count = 0
  @all = []
  @last_id = 0

  def initialize(params = {})
    assign_attributes(params)
  end

  def user
    User.find(user_id)
  end

  def valid?
    !user_id.nil? && user_id != 0 && !body.nil? && !body.empty?
  end

  def delete
    return unless @id
    @id = nil
    Tweet.count -= 1
    Tweet.all.delete(self)
    user.tweets.delete(self) if user_id
  end

  def destroy
    delete
  end

  private

  def assign_attributes(params)
    @body = params[:body] if params.key?(:body)
    @user_id = params[:user_id].to_i if params.key?(:user_id)
  end

  def attributes
    { body: @body, user_id: @user_id }
  end

  def set_up_new_instance
    Tweet.count += 1
    @id = Tweet.add_id
    Tweet.all << self
    user.tweets << self
  end
end
