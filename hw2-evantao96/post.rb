require './user.rb'
require './referenceable.rb'

class Post
  attr_accessor :title
  attr_accessor :body
  attr_accessor :user
  attr_reader :id

  @all = []
  @count = 0
  @last_id = 0

  def self.all
    @all 
  end

  def self.count
    @count
  end

  def self.last_id
    @last_id
  end

  def self.add_count
    @count += 1
  end

  def self.add_id
    @last_id += 1
  end

  def self.find(id)
    if id <= @last_id
      return @all[id]
    else
      return nil 
    end
  end

  def initialize(params = {})
    assign_attributes(params)
  end

  def valid?
    return !@title.nil? && !@body.nil? && !@user.nil?
  end

  def save
    if self.valid?
      if @id.nil?
        Post.all << self
        Post.add_count
        Post.add_id
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
      @count -= 1
      if self.valid?
        @all.delete(self)
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
