require './user.rb'
require './referenceable.rb'

class Post

  extend Referenceable::ClassMethods
  include Referenceable::InstanceMethods

  attr_accessor :title, :body, :user

  @all = []
  @count = 0
  @last_id = 0

  def initialize(params = {})
    assign_attributes(params)
  end

  def valid?
    return !@title.nil? && !@body.nil? && !@user.nil?
  end

  def save
    if self.valid?
      if @id.nil?
        Post.count += 1
        @id = Post.add_id
        Post.all << self
        @user.posts << self
      end
      return true
    else
      return false
    end
  end

  def update(params = {})
    my_hash = {:title => @title, :body => @body, :user => @user}
    @title = params[:title] if params.key?(:title)
    @body = params[:body] if params.key?(:body)
    @user = params[:user] if params.key?(:user)
    if self.valid?
      self.save
    else
      @title = my_hash[:title]
      @body = my_hash[:body]
      @user = my_hash[:user]
      return false
    end
  end

  def delete
    unless @id.nil?
      @id = nil
      Post.count -= 1
      Post.all.delete(self)
      unless @user.nil?
        @user.posts.delete(self)
      end
    end
    return self
  end

  def destroy
    delete 
  end

  private

  def assign_attributes(params)
    @title = params[:title] if params.key?(:title)
    @body = params[:body] if params.key?(:body)
    @user = params[:user] if params.key?(:user)
  end

  def attributes
    { title: @title, body: @body, user: @user }
  end

  def set_up_new_instance
    Post.count += 1
    @id = Post.add_id
    Post.all << self
    @user.posts << self
  end
end
