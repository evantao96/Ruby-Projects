# Homework 5: Book Log
Due **October 18, 2017 at 11:59pm**.

## Before Starting
Be sure to review lectures <a href="https://www.seas.upenn.edu/~cis196/lectures/CIS196-2017f-lecture4.pdf" target="_blank">4</a> and <a href="https://www.seas.upenn.edu/~cis196/lectures/CIS196-2017f-lecture5.pdf" target="_blank">5</a>.

## Gems
Run the `bundle install` command. This will install all gems listed in the `Gemfile`.

## Task
In this homework, you will implement a simple book log where you can create and view authors and the books they've written. This homework assignment will use a persistent database.

You can run `rails console` (or `rails c`) to bring up an interactive console that will allow you to create authors and books. However, you will also be able to run `rails server` (or `rails s`) and visit http://localhost:3000 to see your code in action! Note that you must have the server running in order to be able to visit localhost. While making changes, you will not have to restart the server every time.

Similar to previous homeworks assignments, you will be provided with a complete test suite. To run the tests, you can run `rspec`. To check your style, run `rubocop`.

## Migrations & Models
We have provided the migration files for this assignment. Take a look at the two files in `db/migrate`. You will see that an `Author` has a `name` and a `Book` has a `title`, `year`, and an `author_id`.

We've also provided you with the `Author` and `Book` models with basic validations. For this assignment, you will need to link the models together with ActiveRecord associations so that an author can have many books, and a book can belong to only one author. When an author is destroyed, their associated books should be destroyed as well.

Run `rails db:create` then `rails db:migrate` in your terminal before you move on. This creates the database on your local machine and run the pending migrations to create the database tables that you will need.

## Controllers
You will need to define the 7 RESTful routes for authors and books. Create and fill in `AuthorsController` and `BooksController` and define the necessary routes in `config/routes.rb`. For this assignment, you are allowed to use the ScaffoldController generator (it'll make your life easier).

Define an `index` action inside of `WelcomeController` and create an instance variable that is an array containing the titles of your three favorite books.

## Views
The views for authors and books are provided to you intact, but you will have to fill in the homepage (`app/views/welcome/index.html.erb`).

1. Add a Heading 1 containing the text 'Book Log'.
2. Add a paragraph that welcomes the user the book log application.
3. Create a Heading 3 with the text 'My Favorite Books:'.
4. Create an ordered list.
5. Inside of the ordered list, you should iterate through the array of your favorite book titles that you created in the controller.
6. For each book title, you should make a list item with the title in italics.
7. Use the Rails `link_to` helper to create a link to the author index page with the text 'See all Authors'.
8. Use the Rails `link_to` helper to create a link to the book index page with the text 'See all Books'.

## Submitting
To submit your assignment, `cd` into the Homework 5 directory. Run `git status` to see all of the changes that you've made. Run `git add .` to add all of the changed files and `git status` to confirm that they all appear in green. Run `git commit -m "Complete Homework 5"` to commit your changes locally (note that you can change the commit message to anything you want). Run `git push -u origin master` to push up the changes to your Homework 5 GitHub repository.

Visit Travis CI to see the result of your submission. You will be able to see all of your failed test cases and style offenses. You can submit as many times as you'd like, only your last submission will be graded.
