describe 'Post' do
  before(:each) do
    load './post.rb'
    load './user.rb'
  end

  let!(:user) { User.new(name: 'User 1') }
  let!(:user2) { User.new(name: 'User 2') }
  let!(:post) { Post.new(user: user, title: 'title 1', body: 'body 1') }
  let!(:post2) { Post.new(user: user2, title: 'title 2', body: 'body 2') }

  it 'doesn\'t have any class variables' do
    expect(Post.class_variables.size).to eql(0)
  end

  describe '#id' do
    it 'is an instance method' do
      expect(Post.instance_methods).to include(:id)
    end

    it 'returns nil if no id has been set' do
      expect(post.id).to be_nil
    end

    it 'returns the post\'s id if it has been set' do
      post.save
      expect(post.id).to eql(1)
    end
  end

  describe '#id=' do
    it 'does not exist' do
      expect { post.id = 2 }.to raise_error(NoMethodError)
    end
  end

  describe '#user' do
    it 'is an instance method' do
      expect(Post.instance_methods).to include(:user)
    end
  
    it 'returns the post\'s user' do
      expect(post.user).to eql(user)
    end
  end

  describe '#user=' do
    it 'is an instance method' do
      expect(Post.instance_methods).to include(:user=)
    end

    it 'changes the post\'s user' do
      post.user = user2
      expect(post.user).to eql(user2)
    end
  end

  describe '#title' do
    it 'is an instance method' do
      expect(Post.instance_methods).to include(:title)
    end
  
    it 'returns the post\'s title' do
      expect(post.title).to eql('title 1')
    end
  end

  describe '#title=' do
    it 'is an instance method' do
      expect(Post.instance_methods).to include(:title=)
    end

    it 'changes the post\'s title' do
      post.title = 'Changed Title'
      expect(post.title).to eql('Changed Title')
    end
  end

  describe '#body' do
    it 'is an instance method' do
      expect(Post.instance_methods).to include(:body)
    end
  
    it 'returns the post\'s body' do
      expect(post.body).to eql('body 1')
    end
  end

  describe '#body=' do
    it 'is an instance method' do
      expect(Post.instance_methods).to include(:body=)
    end

    it 'changes the post\'s body' do
      post.body = 'Changed Body'
      expect(post.body).to eql('Changed Body')
    end
  end

  describe '::count' do
    it 'is a class method' do
      expect(Post.methods).to include(:count)
    end

    it 'returns the current count of posts' do
      Post.count = 1
      expect(Post.count).to eql(1)
    end
  end

  describe '::count=' do
    it 'is a class method' do
      expect(Post.methods).to include(:count=)
    end

    it 'sets the count of posts' do
      Post.count = 500
      expect(Post.count).to eql(500)
    end
  end

  describe '::all' do
    it 'is a class method' do
      expect(Post.methods).to include(:all)
    end

    it 'returns all posts' do
      Post.all << post
      Post.all << post2
      expect(Post.all).to match_array([post, post2])
    end
  end

  describe '::all=' do
    it 'does not exist' do
      expect { Post.all = 2 }.to raise_error(NoMethodError)
    end
  end

  describe '::find' do
    it 'is a class method' do
      expect(Post.methods).to include(:find)
    end

    it 'returns nil if no post has provided id' do
      expect(Post.find(1)).to be_nil
    end

    it 'returns the post with provided id' do
      post.save
      expect(Post.find(1)).to eql(post)
    end
  end

  describe '#initialize' do
    it 'assigns the variables from params' do
      new_post = Post.new(user: user, title: 'New Title', body: 'New Body')
      expect(new_post.user).to eql(user)
      expect(new_post.title).to eql('New Title')
      expect(new_post.body).to eql('New Body')
    end
  end

  describe '#valid?' do
    it 'is an instance method' do
      expect(Post.instance_methods).to include(:valid?)
    end

    it 'returns true if the post is valid' do
      expect(post.valid?).to eql(true)
    end

    it 'returns false if the post is not valid' do
      expect(Post.new.valid?).to eql(false)
    end
  end

  describe '#save' do
    it 'is an instance method' do
      expect(Post.instance_methods).to include(:save)
    end

    context 'when post is not valid' do
      it 'returns false' do
        expect(Post.new.save).to eql(false)
      end

      it 'does not increment count' do
        old_count = Post.count
        Post.new.save
        expect(Post.count).to eql(old_count)
      end

      it 'does not assign an id to the post' do
        post3 = Post.new
        post3.save
        expect(post3.id).to be_nil
      end

      it 'does not add the post to the all array' do
        post3 = Post.new
        post3.save
        expect(Post.all).to_not include(post3)
      end

      it 'does not add the post to its user\'s posts array' do
        post3 = Post.new(user: user)
        post3.save
        expect(post3.user.posts).to_not include(post3)
      end
    end

    context 'when the post is valid and does not have an id' do
      it 'increments count' do
        old_count = Post.count
        post.save
        post2.save
        expect(Post.count).to eql(old_count + 2)
      end

      it 'assigns the correct id' do
        post.save
        post2.save
        expect(post.id).to eql(1)
        expect(post2.id).to eql(2)
      end

      it 'adds the post to the all array' do
        post.save
        post2.save
        expect(Post.all).to include(post)
        expect(Post.all).to include(post2)
      end

      it 'adds the post to its user\'s posts array' do
        post.save
        expect(post.user.posts).to include(post)
      end
    end

    context 'when the post is valid and already has an id' do
      it 'does not increment count' do
        post.save
        Post.count = 4
        post.save
        expect(Post.count).to eql(4)
      end

      it 'does not assign a new id to the post' do
        post.save
        old_id = post.id
        post.save
        expect(post.id).to eql(old_id)
      end

      it 'does not add post to the all array' do
        post.save
        post.save
        expect(Post.all.count(post)).to eql(1)
      end

      it 'does not add the post to its user\'s posts array' do
        post.save
        post.save
        expect(post.user.posts.count(post)).to eql(1)
      end
    end
  end

  describe '#update' do
    it 'is an instance method' do
      expect(Post.instance_methods).to include(:update)
    end

    context 'when post is not valid' do
      it 'does not change the post\'s attributes' do
        post.update({})
        expect(post.title).to eql('title 1')
        expect(post.body).to eql('body 1')
        expect(post.user).to eql(user)
      end

      it 'returns false' do
        expect(post.update(user: nil)).to eql(false)
      end

      it 'does not call save' do
        expect(post).to_not receive(:save)
        post.update(user: nil)
      end
    end

    context 'when post is valid' do
      it 'updates the post\'s attributes' do
        post.update(title: 'New Title', body: 'New Body', user: user2)
        expect(post.title).to eql('New Title')
        expect(post.body).to eql('New Body')
        expect(post.user).to eql(user2)
      end

      it 'returns true' do
        expect(post.update(title: 'New Title', body: 'New Body', user: user2)).to eql(true)
      end

      it 'calls save' do
        expect(post).to receive(:save)
        post.update(title: 'New Title', body: 'New Body', user: user2)
      end
    end
  end

  describe '#delete' do
    it 'is an instance method' do
      expect(Post.instance_methods).to include(:delete)
    end

    context 'when the post does not have an id' do
      it 'does not decrement the post count' do
        old_count = Post.count
        post.delete
        expect(Post.count).to eql(old_count)
      end
    end

    context 'when the post has an id' do
      it 'sets the post\'s id to nil' do
        post.save
        post.delete
        expect(post.id).to be_nil
      end

      it 'decrements the post count' do
        post.save
        Post.count = 5
        post.delete
        expect(Post.count).to eql(4)
      end

      it 'removes the post from the all array' do
        post.save
        post.delete
        expect(Post.all).to_not include(post)
      end

      it 'removes the post from its user\'s posts array' do
        post.save
        post.delete
        expect(post.user.posts).to_not include(post)
      end
    end
  end

  describe '#destroy' do
    it 'is an instance method' do
      expect(Post.instance_methods).to include(:destroy)
    end

    it 'calls delete' do
      expect(post).to receive(:delete)
      post.destroy
    end
  end
end

