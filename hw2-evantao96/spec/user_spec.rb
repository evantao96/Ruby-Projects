describe 'User' do
  before(:each) do
    load './user.rb'
    load './post.rb'
  end

  let!(:user) { User.new(name: 'User 1') }
  let!(:user2) { User.new(name: 'User 2') }

  it 'doesn\'t have any class variables' do
    expect(User.class_variables.size).to eql(0)
  end

  describe '#id' do
    it 'is an instance method' do
      expect(User.instance_methods).to include(:id)
    end

    it 'returns nil if no id has been set' do
      expect(user.id).to be_nil
    end

    it 'returns the user\'s id if it has been set' do
      user.save
      expect(user.id).to eql(1)
    end
  end

  describe '#id=' do
    it 'does not exist' do
      expect { user.id = 2 }.to raise_error(NoMethodError)
    end
  end
  
  describe '#posts' do
    it 'is an instance method' do
      expect(User.instance_methods).to include(:posts)
    end

    it 'returns an empty array if there are no posts' do
      expect(user.posts).to eql([])
    end
  end

  describe '#posts=' do
    it 'does not exist' do
      expect { user.posts = 2 }.to raise_error(NoMethodError)
    end
  end

  describe '#name' do
    it 'is an instance method' do
      expect(User.instance_methods).to include(:name)
    end

    it 'returns the user\'s name' do
      expect(user.name).to eql('User 1')
    end
  end

  describe '#name=' do
    it 'is an instance method' do
      expect(User.instance_methods).to include(:name=)
    end

    it 'changes the user\'s name' do
      user.name = 'Changed Name'
      expect(user.name).to eql('Changed Name')
    end
  end

  describe '::count' do
    it 'is a class method' do
      expect(User.methods).to include(:count)
    end

    it 'returns the current count of users' do
      User.count = 1
      expect(User.count).to eql(1)
    end
  end

  describe '::count=' do
    it 'is a class method' do
      expect(User.methods).to include(:count=)
    end

    it 'sets the count of users' do
      User.count = 500
      expect(User.count).to eql(500)
    end
  end

  describe '::all' do
    it 'is a class method' do
      expect(User.methods).to include(:all)
    end

    it 'returns all users' do
      User.all << user
      User.all << user2
      expect(User.all).to match_array([user, user2])
    end
  end

  describe '::all=' do
    it 'does not exist' do
      expect { User.all = 2 }.to raise_error(NoMethodError)
    end
  end

  describe '::find' do
    it 'is a class method' do
      expect(User.methods).to include(:find)
    end

    it 'returns nil if no user has provided id' do
      expect(User.find(1)).to be_nil
    end

    it 'returns the user with provided id' do
      user.save
      expect(User.find(1)).to eql(user)
    end
  end

  describe '#initialize' do
    it 'creates an empty posts array for the user' do
      expect(User.new.posts).to match_array([])
    end

    it 'assigns the variables from params' do
      new_user = User.new(name: 'New User')
      expect(new_user.name).to eql('New User')
    end
  end

  describe '#valid?' do
    it 'is an instance method' do
      expect(User.instance_methods).to include(:valid?)
    end

    it 'returns true if the user is valid' do
      expect(user.valid?).to eql(true)
    end

    it 'returns false if the user is not valid' do
      expect(User.new.valid?).to eql(false)
    end
  end

  describe '#save' do
    it 'is an instance method' do
      expect(User.instance_methods).to include(:save)
    end

    context 'when user is not valid' do
      it 'returns false' do
        expect(User.new.save).to eql(false)
      end
      
      it 'does not increment count' do
        old_count = User.count
        User.new.save
        expect(User.count).to eql(old_count)
      end

      it 'does not assign an id to the user' do
        user3 = User.new
        user3.save
        expect(user3.id).to be_nil
      end

      it 'does not add the user to the all array' do
        user3 = User.new
        user3.save
        expect(User.all).to_not include(user3)
      end
    end

    context 'when the user is valid and does not have an id' do
      it 'increments count' do
        old_count = User.count
        user.save
        user2.save
        expect(User.count).to eql(old_count + 2)
      end

      it 'assigns the correct id' do
        user.save
        user2.save
        expect(user.id).to eql(1)
        expect(user2.id).to eql(2)
      end

      it 'adds the user to the all array' do
        user.save
        user2.save
        expect(User.all).to include(user)
        expect(User.all).to include(user2)
      end
    end

    context 'when the user is valid and already has an id' do
      it 'does not increment count' do
        user.save
        User.count = 4
        user.save
        expect(User.count).to eql(4)
      end

      it 'does not assign a new id to the user' do
        user.save
        old_id = user.id
        user.save
        expect(user.id).to eql(old_id)
      end

      it 'does not add the user to the all array' do
        user.save
        user.save
        expect(User.all.count(user)).to eql(1)
      end
    end
  end

  describe '#update' do
    it 'is an instance method' do
      expect(User.instance_methods).to include(:update)
    end

    context 'when user is not valid' do
      it 'does not change the user\'s attributes' do        
        user.update(name: nil)
        expect(user.name).to eql('User 1')
      end

      it 'returns false' do
        expect(user.update(name: nil)).to eql(false)
      end

      it 'does not call save' do
        expect(user).to_not receive(:save)
        user.update(name: nil)
      end
    end

    context 'when user is valid' do
      it 'updates the user\'s attributes' do
        user.update(name: 'New Name')
        expect(user.name).to eql('New Name')
      end

      it 'returns true' do
        expect(user.update(name: 'New Name')).to eql(true)
      end

      it 'calls save' do
        expect(user).to receive(:save)
        user.update(name: 'New Name')
      end
    end
  end

  describe '#delete' do
    it 'is an instance method' do
      expect(User.instance_methods).to include(:delete)
    end

    context 'when the user does not have an id' do
      it 'does not decrement the user count' do
        old_count = User.count
        user.delete
        expect(User.count).to eql(old_count)
      end
    end

    context 'when the user has an id' do
      it 'sets the user\'s id to nil' do
        user.save
        user.delete
        expect(user.id).to be_nil
      end

      it 'decrements the user count' do
        user.save
        User.count = 5
        user.delete
        expect(User.count).to eql(4)
      end

      it 'removes the user from the all array' do
        user.save
        user.delete
        expect(User.all).to_not include(user)
      end
    end
  end

  describe '#destroy' do
    it 'is an instance method' do
      expect(User.instance_methods).to include(:destroy)
    end

    it 'destroys the user\'s posts' do
      post1 = Post.new
      post2 = Post.new
      user.posts << post1
      user.posts << post2
      expect(post1).to receive(:destroy)
      expect(post2).to receive(:destroy)
      user.destroy
    end

    it 'clears the user\'s posts array' do
      user.posts << Post.new
      user.destroy
      expect(user.posts).to match_array([])
    end

    it 'calls delete' do
      expect(user).to receive(:delete)
      user.destroy
    end
  end
end
