class User

  def self.add_id
    @last_id += 1
  end

  def initialize(params = {})
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
