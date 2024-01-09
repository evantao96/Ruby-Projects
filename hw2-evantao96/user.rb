require './post.rb'
require './referenceable.rb'

class User

  extend Referenceable::ClassMethods
  include Referenceable::InstanceMethods

  attr_accessor :name
  attr_reader :posts

  @all = []
  @count = 0
  @last_id = 0

  def initialize(params = {})
    assign_attributes(params)
    @posts = []
  end

  def valid?
    return !@name.nil? && !@posts.nil?
  end

  def save
    if self.valid?
      if @id.nil?
        User.count += 1
        @id = User.add_id
        User.all << self
      end
      return true
    else
      return false
    end
  end

  def update(params = {})
    my_hash = {:name => @name, :posts => @posts}
    @name = params[:name] if params.key?(:name)
    if self.valid?
      self.save
    else
      @name = my_hash[:name]
      return false
    end
  end

  def delete
    unless @id.nil?
      @id = nil
      User.count -= 1
      User.all.delete(self)
    end
    return self
  end

  def destroy
    @posts.each do |my_post|
      my_post.destroy
    end
    @posts = []
    self.delete
  end

  private

  def assign_attributes(params)
    @name = params[:name] if params.key?(:name)
  end

  def attributes
    { name: @name }
  end

end
