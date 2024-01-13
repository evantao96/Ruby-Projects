[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-24ddc0f5d75046c5622901739e7c5dd533143b0c8e959d652212380cedb1ea36.svg)](https://classroom.github.com/a/rqy8ZOt4)
# Homework 6: Penn InTouch Lite
Due **October 25, 2017 at 11:59pm**.

## Before Starting
Be sure to review lectures <a href="https://www.seas.upenn.edu/~cis196/lectures/CIS196-2017f-lecture5.pdf" target="_blank">5</a> and <a href="https://www.seas.upenn.edu/~cis196/lectures/CIS196-2017f-lecture6.pdf" target="_blank">6</a>.

## Gems
Run the `bundle install` command to insall all of the gems listed in the `Gemfile`.

## Task
In this homework, you will implement a simple course scheduling app. This app lets users enroll students in courses and write reviews for courses, which can be edited or deleted.

You can run `rails console` (or `rails c`) to bring up an interactive console taht will allow you to create students, courses, and reviews. However, you will also be able to run `rails server` (or `rails s`) and visit http://localhost:3000 to see your code in action! Note that you must have the server running in order to be able to visit localhost. While making changes, you will not have to restart the server every time.

Similar to previous homework assignments, you will be provided with a complete test suite. To run tests, you can run `rspec`. To check your style, run `rubocop`.

## Migrations
You may use the Rails migration generator in this assignment.

**Student** The students table should have `first_name` and `last_name` columns.<br>
**Course** The courses table should have `title` and `description` columns.<br>
**StudentsCourse** The students_courses table should have foreign key references to the students and courses table.
**Review** The reviews table should have a `content` column and a column with a foreign id to the courses table. Foreign keys should be generated with the `references` type.

## Models
We have provided `Student`, `Course`, and `Review` models with basic validations. For this assignment, you will need to link the models together with ActiveRecord associations such that
1. a course can have many reviews and a review can belong to only one course,
2. a course can have and belong to many students,
3. a student can have and belong to many courses.

Also create an instance method in `Student` that will return the student's full name. (i.e. - The student's first and last name separated by a space)

Once you've set up the models and migrations, be sure to run `rails db:migrate`.

## Controllers
You may use the Rails Scaffold Controller generator in this assignment.

### WelcomeController
This controller should manage the root page (i.e. '/') with an `index` method.

### CoursesController
Generate the 7 RESTful routes as usual. This would be a good place to use the Scaffold Controller generator. Remember that a course has a `title` and a `description`.

#### show
Inside of the `show` action, define an instance variable `@students` that contains all of the current student objects. Define an instance variable `@review` that contains a new instance of the `Review` class.
 
#### add_student
Define an `add_student` action. This should be a POST request to `courses/:id/students`. You should define the `@course` variable in this method by using the `set_course` `before_action`. If `student_id` exists within the `params` hash, find the student with corresponding `student_id` and add this student to the course's list of students unless the student is already in the list. Redirect to the course's show page.<br>
*NOTE:* You are not creating a new student here, you are just adding the student with the specified `student_id` to the course's student list.

#### delete_student
Define a `delete_student` action. This should be a DELETE request to `courses/:id/students/:student_id`. You should define the `@course` variable in this method by using the `set_course` `before_action`. Find the student with the corresponding `student_id` in `params`. Delete the student from the course's array of students and redirect to the course's show page.
*NOTE:* You are not deleting a student here, you are just removing the student with the specified `student_id` from the course's student list.

### StudentsController
Generate the 7 RESTful routes as usual. This would be a good place to use the Scaffold Controller generator. Remember that a student has a `first_name` and `last_name`.

#### show
Inside of the `show` action, define an instance variable `@courses` that contains a list of all current courses.

#### add_course
Define an `add_course` action. This should be a POST request to `students/:id/courses`. You should define the `@student` variable in this method by using the `set_student` `before_action`. If `course_id` exists with the `params` hash, find the course with the corresponding `course_id` and add this course to the student's list of courses unless the course is already in the list. Redirect to the student's show page.<br>
*NOTE:* You are not creating a new course here, you are just adding the course with the specified `course_id` to the student's course list.

#### delete_course
Define a `delete_course` action. This should be a DELETE request to `students/:id/courses/:course_id`. You should define the `@student` variable in this method by using the `set_student` `before_action`. Find the course with the corresponding `course_id` in `params`. Delete the course from the student's array of courses and redirect to the courese's show page.
*NOTE:* You are not deleting a course here, you are just removing the course with the specified `course_id` from the student's course list.

### ReviewsController
You will only need 4 RESTful routes here: `edit`, `create`, `update`, and `destroy`. I recommend writing this controller out by hand instead of using the scaffold controller generator. The routes for reviews will be nested under courses, so you will need a course for each route.

You've been provided with three private methods, `set_course`, `set_review`, and `review_params`. Define a `before_action` that calls the `set_course` method before every action. Define a `before_action` that calls the `set_review` method before the `edit`, `update`, and `destroy` actions.

#### edit
Define an `edit` action. You do not have to add any code inside of this action.

#### create
Define a `create` action. You should create a review with `review_params` through `@course`'s list of reviews. Then redirect to the course's show page.

#### update
Define an `update` action. You should attempt to update `@review` with the given `review_params`. Redirect to the course's show page.

#### destroy
Define a `destroy` action. You should call destroy on `@review` and redirect to the course's show page.

## Routes
In case you weren't defining the routes along the way, here are all of the routes that you should have:
1. The homepage should point to the `welcome` controller's `index` action.
2. The 7 RESTful routes should be defined for `courses` using the `resources` method.
3. There should be a POST request to `courses/:id/students` that uses the `courses` controller's `add_student` action.
4. There should be a DELETE request to `courses/:id/students/:student_id` that uses the `courses` controller's `delete_student` action.
5. Four RESTful routes should be defined for `reviews` (`edit`, `create`, `update`, and `destroy`). You should use the `resources` method for this and nest them under `courses`.
6. The 7 RESTful routes should be defined for `students` using the `resources` methods.
7. There should be a POST request to `students/:id/courses` that uses the `students` controller's `add_course` action.
8. There should be a DELETE request to `students/:id/courses/:course_id` that uses the `students` controller's `delete_course` action.

## Submitting
To submit your assignment, `cd` into the Homework 6 directory. Run `git status` to see all of the changes that you've made. Run `git add .` to add all of the changed files and `git status` to confirm that they all appear in green. Run `git commit -m "Complete Homework 6"` to commit your changes locally (note that you can change the commit message to anything you want). Run `git push -u origin master` to push up the changes to your Homework 6 GitHub repository.

Visit Travis CI to see the result of your submission. You will be able to see all of your failed test cases and style offenses. You can submit as many times as you'd like, only your last submission will be graded.
