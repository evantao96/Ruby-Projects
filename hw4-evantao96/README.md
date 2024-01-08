[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-24ddc0f5d75046c5622901739e7c5dd533143b0c8e959d652212380cedb1ea36.svg)](https://classroom.github.com/a/X6WOKrmw)
# Homework 4: Twitter Clone
Due **October 4, 2017 at 11:59pm**.

## Before Starting
Be sure to review <a href="https://www.seas.upenn.edu/~cis196/lectures/CIS196-2017f-lecture4.pdf" target="_blank">lecture 4</a>. The slides contain most of the functionality that you will need and they will prove to be very useful for this assignment!

## Gems
Run the `bundle install` command. This will install all gems listed in the `Gemfile`.

## Task
In this homework, you will be making a simple Twitter Clone. By the end of the assignment, you will be able to create, view, edit, and delete users and tweets. This homework assignment will not use a database and will instead utilize the files you wrote in Homework 2 (with a few modifications).

You can run `rails console` (or `rails c`) to bring up an interactive console that will allow you to create users and tweets. However, you will also be able to run `rails server` (or `rails s`) and visit http://localhost:3000 to see your code in action! Note that you must have the server running in order to be able to visit localhost. While making changes, you will not have to restart the server every time.

Similar to previous homework assignments, you will be provided with a complete test suite. To run the tests, you can run `rspec`. To check your style, run `rubocop`.

## Model-View-Controller Design Pattern
You'll remember from class that Ruby on Rails makes use of the MVC Design Pattern (refer to the lecture notes for more information). This homework assignment is designed to get you comfortable with working with the Controller layer.

### Model
You've been provided with the models for this assignment. We will be using a User model and a Tweet model. As is convention in Rails, these files are placed inside of `app/models/`. If you open these files, you will notice that they bear a striking resemblace to the User and Post classes that you created in homework 2. Read through the files to understand the few modifications and updated methods.

We've also included the Referenceable module in this assignment. You can find it inside of the `lib/` folder. Also read through this file to understand the modifications that have been made.

### View
You've also been provided with the views for this assignment. If you look inside of `app/views/`, you will notice that there are three directories, `welcome`, `users`, and `tweets`. You will use the file inside of `welcome` to display our site's homepage, the files inside of `users` for pages related to users, and the files inside of `tweets` for pages related to tweets.

## Controller
You will be implementing this layer of the application! You will be working with the three controller files inside of `app/controllers/` and also `config/routes.rb` to define the routes for the application. Before we get started, make sure that you've run `bundle install` and run `rails s` to start the server. Visit http://localhost:3000 in your web browser. You should see the "Yay! You're on Rails!" message.

### WelcomeController
Let's change the root of our website to be an actual page. We want to ensure that when the user visits the homepage of our application, `/`, they see the `app/views/welcome/index.html.erb` file. Note that this route corresponds to http://localhost:3000/ on our local site. Whenever I provide a route like '/users', it represents what would come after the localhost part.

#### index
To start, you should open `app/controllers/welcome_controller.rb`. Inside of the file, you should define a method called `index`. You won't have to add anything to its method body. This method is known as a Controller Action. Since this action is inside of the WelcomeController and is named `index`, it will by default render the corresponding view in `app/views/welcome/index.html.erb`. Now that we have an action that is capable of rendering the HTML file that we want, let's define a route to it.

Inside of `config/routes.rb`, you should set the root of our application to point to the WelcomeController's index action. Refer to the lecture notes on the best way to do this! Return to the app in your web browser (note that you will not have to restart the server) and refresh the page. It may take a second, but you should see our new homepage! Note that most of the links will not work yet since we have not implemented them.

### UsersController
Let's now set up the functionality for interacting with users. We will use RESTful resources for this part of the assignment (refer to the lecture notes for more information). 

#### index
When the user visits `/users`, we want it to render `app/views/users/index.html.erb`. If you open `app/views/users/index.html.erb`, you will see that it makes use of an instance variable, `@users`. This variable needs to be passed to the view from the controller.

Inside of `app/controllers/users_controller.rb`, define an `index` action. Inside of this action, define an instance variable `@users` that contains all of the users that have been defined so far (theres a method inside of the User class that will help here)! By default, this action will render `app/views/users/index.html.erb` and will pass the `@users` instance variable to it.

Now go to `config/routes.rb` and define a route for this action. This route should be a get request to `/users` and it should utilize the Users Controller's `index` action. It should be of the following form:
```ruby
request_type 'path', to: 'controller_name#action'
```

Go back into your web browser and visit `/users` and you should see a Users header, an empty table (since we haven't created any users yet), and a New User button (don't try to click it just yet).

#### new
When the user visits `/users/new`, they should see user's corresponding `new` HTML file. If you open `app/views/users/new.html.erb`, you will see that it makes use of an instance variable, `@user`. Open up the Users Controller and define an action called `new`. Inside of this action, assign the instance variable `@user` to a new instance of the User class. Do not pass any arguments when initializing the User.

Now go to `config/routes.rb` and define a get requestion to `/users/new` that uses the Users Controller's `new` action. Go back into your web browser and visit `/users/new`. You should see a form to create a new user. Don't click the 'Create User' button just yet though!

#### show
When the user visits `/users/:id`, where `:id` corresponds to the id of an existing user, they should see `app/views/users/show.html.erb`. If you open `app/views/users/show.html.erb`, you will see that it makes use of an instance variable, `@user`. This variable needs to be passed to the view from the controller. Inside of `app/controllers/users_controller.rb`, define a `show` action. Inside of this action, you should find the user with the corresponding id and assign it to the instance variable, `@user`. Note that you can access the passed in id through the `params` hash (`params[:id]`).

Now go to `config/routes.rb` and define a get request to `/users/:id` that uses the User Controller's `show` action. Append to the end of this line `, as: 'user'` (so it looks like `request_type 'path', to: 'controller_name#action', as: 'user'`). Don't worry too much about this now, but it will allow us to use some shortcuts later. Since we don't have any users, you won't be able to preview this page just yet.

#### edit
This is the last of our get requests. When the user visits `/users/:id/edit`, they should see the edit form for a user with the corresponding id. You will see that this view makes use of an instance variable named `@user`. Find the user with the corresponding id and assign it to the `@user` instance variable.

Now go to `config/routes.rb` and define a get request to `/users/:id/edit`. Similar to `sho`, you should append `, as: 'edit_user'`. You won't be able to test this route until we finally create some users, so let's do that!

#### create
This will not be a get request, so it will not have a corresponding view. This action will be called whenever the user submits the `new` form. Create an action inside of the Users Controller that is named `create`. Inside of this action you should create a new user with `user_params` and assign this new user to the `@user` instance variable. Note that `user_params` is a private method defined inside of the controller that will contain the values submitted with the form. 

You should then attempt to save the user. If the user saved successfully (i.e. `@user.save` returned true), you should redirect to the user's show page. To accomplish this, you can simply write `redirect_to @user`. If the user did not save properly, you should re-render the new template using `render :new`.

Now go to `config/routes.rb` and define a post request to `/users` that utilizes the action you just created. Go back into your web browser and visit `/users/new`. Try clicking the 'Create User' button without entering a name. It should just refresh the page (in future assignments, we will configure the form to display the form errors). Now enter a name and press the 'Create User' button. If all goes well, you should be redirected to `/users/1`. Click the 'Edit' button and you should see a form similar to the `new` form, but with the user's name already filled in. You can't submit the form yet though, let's change that!

#### update
This will not be a get request, so it will not have a corresponding view. This action will be called whenever the user submits the `edit` form. Create an action inside of the Users Controller that is named `update`. When the `edit` form is submitted, it will contain an id in params. Find the user with the corresponding id and assign it to the `@user` instance variable.

You should then attempt to update the user with the `user_params`. If the user updated successfully (i.e. `@user.update(user_params)` returned true), you should redirect to the user's show page. Otherwise, you should re-render the `edit` template.

Now to go `config/routes.rb` and define a patch request to `/users/:id`. Go back into your web browser and visit `/users`. You will likely have to create a new user since we're not using a database and the data cannot persist. Once you've created a new user, you should be on `/users/:id`. Click the 'Edit' button and on the form, erase the user's name. Click 'Update User' and it should just refresh the page. Type a new name for the user into the textbox, click 'Update User', and you should be redirected to `/users/:id`. The user's name should now be changed.

#### destroy
This will not be a get request, so it will not have a corresponding view. This action will be called whenever the user attempts to delete an existing user. Create an action inside of the the Users Controller called `destroy`. The `params` for this action will contain an id. Find the user with the corresponding id and assign it to an instance variable, `@user`. Call `destroy` on `@user` and redirect to the users index page. This can be accomplished with `redirect_to users_path`.

Now go to `config/routes.rb` and define a delete request to `/users/:id`. Go back into your web browser and visit `/users`. You will likely have to create a new user. Once you've created a new user, you should be on `/users/:id`. Click the 'Delete' button. You should be redirected to `/users`. If the user was deleted correctly, they should not appear inside of the table on this page.

### TweetsController
Generate the above 7 actions and routes for the Tweet model.

## Cleaning Up Routes
At this point you should have 15 routes, 1 for the homepage, 7 for users, and 7 for tweets. Run the `rails routes` command to see all of the routes that you have generated. Go back into `config/routes.rb` and replace the 7 routes for users with `resources :users`. Do the same for the 7 routes for tweets. Run `rails routes` again and you should see that you have the exact same 15 routes.

Go through the application to make sure that all of the functionality still works. Congratulations, you've created your first Rails app!

## Submitting
To submit your assignment, `cd` into the Homework 4 directory. Run `git status` to see all of the changes that you've made. Run `git add .` to add all of the changed files and `git status` to confirm that they all appear in green. Run `git commit -m "Complete Homework 4"` to commit your changes locally (note that you can change the commit message to anything you want). Run `git push -u origin master` to push up the changes to your Homework 4 GitHub repository.

Visit Travis CI to see the result of your submission. You will be able to see all of your failed test cases and style offenses. You can submit as many times as you'd like, only your last submission will be graded.
