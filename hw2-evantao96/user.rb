require './post.rb'
require './referenceable.rb'

class User
  attr_accessor :name
  attr_reader :posts
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
    @posts = []
  end

  def valid?
    return !@name.nil? && !@posts.nil?
  end

  def save
    if self.valid?
      if @id.nil?
        User.all << self
        User.add_count
        User.add_id
      end
      return true
    else
      return false
    end
  end

  def update(params = {})
    my_hash = {:name => @title, :posts => @posts}
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
      @count -= 1
      if self.valid?
        @all.delete(self)
      end
    end
    return self
  end

  def destroy
    @posts.each do |my_post|
      my_post.destroy
    end
    @posts = []
  end

  private

  def assign_attributes(params)
    @name = params[:name] if params.key?(:name)
  end

  def attributes
    { name: @name }
  end

  def set_up_new_instance
    User.count += 1
    @id = User.add_id
    User.all << self
  end
end
