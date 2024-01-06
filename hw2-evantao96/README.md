[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-24ddc0f5d75046c5622901739e7c5dd533143b0c8e959d652212380cedb1ea36.svg)](https://classroom.github.com/a/O4DYD9Sl)
# Homework 2: Object Orientation
Due **September 20, 2017 at 11:59pm**.

## Before Starting
Be sure to review <a href="https://www.seas.upenn.edu/~cis196/lectures/CIS196-2017f-lecture2.pdf" target="_blank">Lecture 2</a>.

## Task
This assignment is designed to help you become more comfortable with Object-Oriented Design in Ruby. You will build out the functionality for a basic blog by implementing `User` and `Post` classes and the `Referenceable` module. You will see a lot of the functionality that you implement in this assignment again when we get to Rails.

Similar to homework 1, to test your classes, run `ruby bin/console.rb`. A Pry REPL (very similar to `irb`) will start, and your classes will be loaded for you! To exit the REPL, use the `exit` method.

To check your style, run `rubocop`. To run the test cases, run `rspec`.

### post.rb
#### Require other files
You will need access to the `User` class and the `Referenceable` module, so `require` these two files. After doing this, you should be able to instantiate `User` in this file.

#### Basic Attributes
Every instance of `Post` should have a **title**, **body**, **user**, and **id**. An instance should be able to read and write its own title, body, and user, but only be able to read its id.

#### Class Methods
**all** The `Post` class should keep track of all its instances in an array called `all`. Calling `Post.all` should return the `all` array.

**count** Calling `Post.count` should return the number of `Post` instances. While you can just call `Post.all.size` to get the number of instances, I specifically want you to start with a count of 0 and update it as instances are created and deleted (You will need to write reader and writer methods for `count` to do this). **Remember not to use class variables.**

**last_id** The `Post` class should keep track of the last assigned id. This should be 0 initially.

**find** You should be able to pass the `id` of a post to the `find` method and return the instance if it exists and `nil` if it does not.

#### Helper Methods
I've provided four helper methods to assist with this assignment. I won't tell you where to use these methods, but it'll make your life much easier if you use them in the correct methods.

**add_id** This is a class method that increments the last assigned id and returns the new value.

**assign_attributes** This method takes in a `params` hash and sets the title, body, and user from this hash.

**attributes** This method returns a hash containing the post's current attributes.

**set_up_new_instance** This method increments the count in the `Post` class. It then sets the id of the new instance, adds the post to the `Post` class's all array and to its user's posts array.

#### Initialization
`Post` will take in an optional `params` hash upon initialization. Assign the post's title, body, and user to the corresponding value in the `params` hash, but only if the key exists in the hash.

After doing this, you should be able to instantiate a user and post and call
```ruby
user = User.new
post = Post.new(user: user, title: 'Title', body: 'Body')
p post.title
p post.body
p post.user
```

#### Instance Methods
**valid?** This method should return true if the instance's title, body, and user and not nil. If any of the attributes are nil, it should return false.

**save** If the instance is not valid, this method should immediately return false. If the instance has never been saved before (i.e. its id is nil), the count should be incremented, the instance should be assigned the next id, the instance should be added to the `Post` class's all array, and added to its user's posts array. Regardless of whether the instance had been saved before, it should return true.

**update** This method should take in a `params` hash. It should store get the current attributes and store them in a local variable. Assign the title, body, and user instance variables to the corresponding values in the `params` hash if the keys are present in the hash. If the instance is valid after changing these variables, you should save the instance. Otherwise, You should reassign the title, body, and user variables to their old values and return false.

**delete** If the instance's id is not `nil`, set the id to `nil`, decrement the count, delete the post from the `Post` class's all array, and delete the post from its user's `posts` array if it has a user. Regardless of whether or not the id was `nil` to begin with, the instance should be returned.

**destroy** This method should just call the `delete` method.

### user.rb
#### Require other files
You will need access to the `Post` class and the `Referenceable` module, so `require` these two files. After doing this, you should be able to instantiate `Post` in this file.

#### Basic Attributes
Every instance of `User` should have a **name**, **posts** array, and **id**. An instance should be able to read and write its own name but only be able to read its id and **posts** array.

#### Class Methods
**all** The `User` class should keep track of all its instances in array called `all`. Calling `User.all` should return the `all` array.

**count** Calling `User.count` should return the number of `User` instances. While you can just call `User.all.size` to get the number of instances, I specifically want you to start with a count of 0 and update it as instances are created and deleted (You will need to write reader and writer methods for `count` to do this). **Remember not to use class variables.**

**last_id** The `User` class should keep track of the last assigned id. This should be 0 initially.

**find** You should be able to pass the `id` of a user to the `find` method and return the instance if it exists and `nil` if it does not.

#### Helper Methods
I've provided four helper methods to assist with the assignment. I won't tell you where to use thse methods, but it'll make your life much easier if you use them in the correct methods.

**add_id** This is a class method that increments the last assigned id and returns the new value.

**assign_attributes** This method takes in a `params` hash and sets the name from this hash.

**attributes** This method returns a hash containing the user's current attributes.

**set_up_new_instance** This method increments the count in the `User` class. It then sets the id of the new instance, adds the user to the `User` class's all array.

#### Initialization
`User` will take in an optional `params` hash upon initialization. Assign the user's name to the corresponding value in the `params` hash, but only if the key exists in the hash. Initialize the user's `posts` array.

After doing this, you should be able to instantiate a user and call
```ruby
user = User.new(name: 'Name')
p user.name
p user.posts
```

#### Instance Methods
**valid?** This method should return true if the instance's title, body, and user and not nil. If any of the attributes are nil, it should return false.

**save** If the instance is not valid, this method should immediately return false. If the instance has never been saved before (i.e. its id is nil), the count should be incremented, the instance should be assigned the next id, and the instance should be added to the `User` class's all array. Regardless of whether the instance had been saved before, it should return true.

**update** This method should take in a `params` hash. It should get the current attributes and store them in a local variable. Assign the name instance variable to the corresponding value in the `params` hash if the key is present in the hash. If the instance is valid after changing these variables, you should save the instance. Otherwise, You should reassign the name variable to its old value and return false.

**delete** If the instance's id is not `nil`, set the id to `nil`, decrement the count, and delete the user from the `User` class's all array. Regardless of whether or not the id was `nil` to begin with, the instance should be returned.

**destroy** This method should iterate through the `posts` array and call `destroy` on each post. It should then clear the user's `posts` array. Finally, it should call the `delete` method.

### referenceable.rb
**Abstract similar methods** It seems repetitive to have such similar methods in two different classes, especially because those methods aren't particularly specific to either class. The id, update, and save instance methods and the class methods related to count, find, all, incrementing the last id used can be abstracted into the `Referenceable` module. Remember to use nested modules to separate instance and class methods and not to use class variables. Delete the methods from the classes, and mix this module into both the `Post` and `User` classes.

## Feedback
This is a new homework assignment this semester so any feedback would be appreciated. You can provide optional feedback in the feedback.txt file located in this assignment. Thanks!

## Submitting
To submit your assignment, `cd` into the Homework 2 directory. Run `git status` to see all of the changes that you've made. Run `git add .` and `git commit -m "Complete Homework 2"` to commit your changes locally (note that you can change the commit message to anything you want). Run `git pull` if you haven't already to pull down the changes to the README. Run `git push -u origin master` to push up the changes to your Homework 2 GitHub repository.

Visit <a href="https://www.travis-ci.com/cis196-2017f" target="_blank">Travis CI</a> to see the result of your submission. You will be able to see all of your failed test cases and style offenses. You can submit as many times as you'd like, only your last submission will be graded.
