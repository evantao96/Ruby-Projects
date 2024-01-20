class User
  include ActiveModel::Model
  include Referenceable::InstanceMethods
  extend Referenceable::ClassMethods

  attr_reader :tweets
  attr_accessor :name

  @count = 0
  @all = []
  @last_id = 0

  def initialize(params = {})
    @tweets = []
    assign_attributes(params)
  end

  def valid?
    !name.nil? && !name.empty?
  end

  def delete
    return unless @id
    @id = nil
    User.count -= 1
    User.all.delete(self)
  end

  def destroy
    @tweets.each(&:destroy)
    @tweets.clear
    delete
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
