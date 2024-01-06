[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-24ddc0f5d75046c5622901739e7c5dd533143b0c8e959d652212380cedb1ea36.svg)](https://classroom.github.com/a/LMwi2B2F)
# Homework 1: Finger Exercises
Due **September 13, 2017 at 11:59pm**.

## Before Starting
Be sure to review <a href="https://www.seas.upenn.edu/~cis196/lectures/CIS196-2017f-lecture1.pdf" target="_blank">Lecture 1</a>.

## Task
You will be given six methods to implement. To test them for yourself, `gem install bundler` (if you haven't already installed it), run `bundle install` to install all of the gems in the Gemfile and then run `ruby bin/console.rb`. A Pry REPL (very similar to `irb`) will start, and your six methods will already be loaded! To exit the REPL, use the `exit` method.

To check your style, run `rubocop`. To run the test cases, run `rspec`.

### 1. Find all even numbers
In the find_evens method, you will return an array of all elements of the array that are even numbers in the same order. If an element is not an integer, it should not be included in the final array. For example, `find_evens([2, 3, 4, 'foo'])` should return [2, 4].

### 2. Find the product
In the product method, you will find the product of all numbers in the array. If an element is not a number, just ignore it. The method should return 0 if it doesn't contain any numbers. For example, `product([1, 2, 3])` should return 6.

### 3. Find all unique elements
In the uniq method, you will return an array of distinct elements from the original array passed into the method in the same order. If a duplicate element is found, it should be removed (e.g. `uniq([1, 2, 1])` should return [1, 2]). The uniq and uniq! methods built into the Array class will be disabled.

### 4. Parse the phone number
In the `parse_phone_number` method, you will parse a string of numbers into the format (123) 456-7890. Because users like to put in all kinds of input, this string of numbers may also contain extraneous spaces and dashes. For example, `parse_phone_number('123-456-7890')` should return '(123) 456-7890', and '1 2 3 4 5 6 7 8 9 0' should be parsed into ''(123) 456-7890'. All input will be a string with 10 numbers and maybe extraneous spaces and dashes.

### 5. Invert the hash
In the invert method, you will invert a hash so that the values become the keys, and the keys become the corresponding values. For example, `invert({ 1 => 'foo', 2 => 'bar' })` will return {'foo' => 1, 'bar' => 2}. If there are duplicate values, the most recent key-value pair should be used, so `invert({ 1 => 'foo', 2 => 'bar', 3 => 'foo' })` will return {'foo' => 3, 'bar' => 2}. The built-in invert method in the Hash class will be disabled.

### 6. Fetch from the hash
In the fetch method, you will implement something similar to Hash's built-in fetch method (And of course, do not use the built-in method). This method should return the value corresponding to the key (the second argument) in the hash (the first argument). If the key is not found in the hash, then the string 'missing' should be returned unless an optional third argument is passed in. If a third argument is passed in, and the key is not found in the hash, then that third argument should be returned. Hint: While you may not change the method name, you may change the arguments as long as the method can accept the same number of arguments.

## Submitting
To submit your assignment, `cd` into the Homework 1 directory. Run `git status` to see all of the changes that you've made. Run `git add .` and `git commit -m "Complete Homework 1"` to commit your changes locally (note that you can change the commit message to anything you want). Run `git push -u origin master` to push up the changes to your Homework 1 GitHub repository.

Visit <a href="https://www.travis-ci.com/cis196-2017f" target="_blank">Travis CI</a> to see the result of your submission. You will be able to see all of your failed test cases and style offenses. You can submit as many times as you'd like, only your last submission will be graded.
