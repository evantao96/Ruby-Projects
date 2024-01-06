class Post
  def self.add_id
    @last_id += 1
  end

  def initialize(params = {})
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
