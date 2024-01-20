Rails.application.routes.draw do

  root 'welcome#index'

  resources :courses do
    resources :reviews
  end

  post 'courses/:id/students' => 'courses#add_student'
  delete '/courses/:id/students/:student_id' => 'courses#delete_student'

  resources :students
  post 'students/:id/courses' => 'students#add_course'
  delete '/students/:id/courses/:course_id' => 'students#delete_course'

end
