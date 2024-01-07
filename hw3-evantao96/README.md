# Homework 3: Radio CLI
Due **September 27, 2017 at 11:59pm**.

## Before Starting
Be sure to review <a href="https://www.seas.upenn.edu/~cis196/lectures/CIS196-2017f-lecture3.pdf" target="_blank">lecture 3</a>.

## Gems
`gem install bundler` if you haven't already and run the `bundle install` command. This will install all gems listed in your `Gemfile`.

## Task
In this homework, you will write tests for a Command Line Interface (CLI) that allows users to add new songs and list existing songs. Similar to previous homeworks, you can run `ruby bin/console.rb` to test the provided classes. Alternatively, you can (and should) run `ruby bin/run.rb` to try running the CLI directly.

To run your tests, you should run `rspec`. Open this file in a web browser to review your test coverage. To check your style, run `rubocop`.

## Review provided classes

### radio.rb

**`#run`**
Runs a continuous loop that waits for input from the user. If the user enters 'exit', the loop will `break`. Otherwise, it will call `match_user_input` with the user's input. It will continually ask the user for input and handle the input until 'exit' is entered.

**`#match_user_input`**
Takes in a string representing the user's input. `Song.add` will be called if the user entered 'add' and `Song.list` will be called  if the user entered 'list'. If any other input was provided, it will output "I didn't understand that".

### song.rb

**Attributes**
Every instance of song has a `name`, `artist_name`, `errors` array, and `validators` array. All of these attributes can be read, but not written. The `Song` class contains an `all` array that keeps track of all songs. The array can be written.

**`::request_info`**
Request a song name and artist name from the user and initialize a new `Song` object with the entered strings.

**`::add`**
Calls `::request_info` and immediately returns if the song is nil or invalid. If the song is valid, it'll add it to the array of all songs and output a success string.

**`::list`**
If the array of all songs is empty, it'll output an appropriate message. If there are songs, it'll output each song in the following format: 'index. Artist Name - Song Name'.

**`#initialize`**
Writes the song's name and artist name from the params hash. Initializes the song's `errors` array to an empty array. It creates a `validators` array that contains the 3 validation methods defined in `Song`.

**`#validate_name`**
Returns a lambda that will add an error to `errors` if the song's name is empty.

**`#validate_artist_name`**
Returns a lambda that will add an error to `errors` if the artist's name is empty.

**`#validate_artist_name`**
Returns a lambda that will add an error to `errors` if the song already exists.

**`#valid?`**
Iterates through `validators` and calls each of the lambdas that the methods return. Outputs all of the errors that get added after calling each validator. Returns true if there are no errors, false otherwise.

## Write tests
Fill in `radio_spec.rb` and `song_spec.rb` with tests for the corresponding classes. You must write at least one test for each method in both classes and all tests must pass. In addition, you must achieve 100% test coverage.

## Submitting
To submit your assignment, `cd` into the Homework 1 directory. Run `git status` to see all of the changes that you've made. Run `git add .` and `git commit -m "Complete Homework 3"` to commit your changes locally (note that you can change the commit message to anything you want). Run `git push -u origin master` to push up the changes to your Homework 3 GitHub repository.

Visit <a href="https://www.travis-ci.com/cis196-2017f" target="_blank">Travis CI</a> to see the result of your submission. You will be able to see all of your failed test cases and style offenses. You can submit as many times as you'd like, only your last submission will be graded.

