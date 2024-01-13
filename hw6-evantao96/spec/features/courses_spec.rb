require 'rails_helper'
require 'rack/builder'

RSpec.feature "Courses", type: :feature do
  let!(:cis196_title) { 'CIS 196' }
  let!(:cis196_description) { 'Ruby on Rails Web Development' }
  let!(:cis196_params) { { title: cis196_title, description: cis196_description } }

  let!(:cis197_title) { 'CIS 197' }
  let!(:cis197_description) { 'Javascript' }
  let!(:cis197_params) { { title: cis197_title, description: cis197_description } }

  describe '#index' do
    before(:each) do
      Course.create(cis196_params)
      Course.create(cis197_params)
      visit '/courses'
    end

    it 'loads the page successfully' do
      expect(status_code).to eq(200)
    end

    it 'lists all course titles' do
      expect(page).to have_text(cis196_description)
      expect(page).to have_text(cis197_description)
    end

    it 'has edit links for each course' do
      expect(page).to have_selector('a i.fa-pencil', count: 2)
    end

    it 'has delete links for each course' do
      expect(page).to have_selector('a i.fa-trash', count: 2)
    end

    it 'has a new course link' do
      expect(page).to have_selector('a', text: 'New Course')
    end
  end

  describe '#show' do
    let!(:course) { Course.create(cis196_params) }
    let!(:student) { course.students.create(first_name: 'First', last_name: 'Student')}
    let!(:review) { course.reviews.create(content: 'First Review') }

    before(:each) { visit "/courses/#{course.id}" }

    it 'loads the page successfully' do
      expect(status_code).to eq(200)
    end

    it 'has the title of the chosen course' do
      expect(page).to have_text(course.title)
    end

    it 'has the description of the chosen course' do
      expect(page).to have_text(course.description)
    end

    it 'lists current students' do
      expect(page).to have_selector('a', text: student.full_name)
    end

    it 'lists course reviews' do
      expect(page).to have_text(review.content)
    end
  end

  describe '#new' do
    before(:each) { visit '/courses/new' }

    it 'loads the page successfully' do
      expect(status_code).to eq(200)
    end

    it 'has title field' do
      expect(page).to have_field('course_title')
    end

    it 'has description field' do
      expect(page).to have_field('course_description')
    end
  end

  describe '#edit' do
    let!(:course) { Course.create(cis196_params) }

    before(:each) { visit "/courses/#{course.id}/edit" }

    it 'loads the page successfully' do
      expect(status_code).to eq(200)
    end

    it 'has the title of the course to be edited' do
      expect(page).to have_text(cis196_title)
    end

    it 'has the description of the course to be edited' do
      expect(page).to have_text(cis196_description)
    end
  end

  describe '#create' do
    before(:each) do
      Course.delete_all
      visit '/courses/new'
      fill_in 'course_title', with: cis196_title
      fill_in 'course_description', with: cis196_description
      click_button 'Create Course'
    end

    it 'redirects to new course' do
      expect(current_path).to eq('/courses/1')
    end

    it 'loads the page successfully' do
      expect(status_code).to eq(200)
    end

    it 'has title of newly created course' do
      expect(page).to have_text(cis196_title)
    end

    it 'has description of newly created course' do
      expect(page).to have_text(cis196_description)
    end
  end

  describe '#update' do
    let!(:course) { Course.create(cis196_params) }

    before(:each) do
      visit "/courses/#{course.id}/edit"
      fill_in 'course_title', with: cis197_title
      fill_in 'course_description', with: cis197_description
      click_button 'Update Course'
    end

    it 'redirects to the course show page' do
      expect(current_path).to eq("/courses/#{course.id}")
    end

    it 'loads the page successfully' do
      expect(status_code).to eq(200)
    end

    it 'does not have the title of the course before update' do
      expect(page).to_not have_text(cis196_title)
    end

    it 'does not have the description of the course before update' do
      expect(page).to_not have_text(cis196_description)
    end

    it 'has the title of the course after update' do
      expect(page).to have_text(cis197_title)
    end

    it 'has the description of the course after update' do
      expect(page).to have_text(cis197_description)
    end
  end

  describe '#destroy' do
    let!(:course) { Course.create(cis196_params) }

    before(:each) { visit "/courses/#{course.id}" }

    it 'has the title of the course before delete' do
      expect(page).to have_text(cis196_title)
    end

    it 'has the description of the course before delete' do
      expect(page).to have_text(cis196_description)
    end

    context 'when delete button is pressed' do
      before(:each) { find("a[href='/courses/#{course.id}']").click }

      it 'redirects to course index page' do
        expect(current_path).to eq('/courses')
      end

      it 'loads the page successfully' do
        expect(status_code).to eq(200)
      end

      it 'does not have the title of the deleted course' do
        expect(page).to_not have_text(cis196_title)
      end

      it 'does not have the description of the deleted course' do
        expect(page).to_not have_text(cis196_description)
      end
    end
  end

  describe '#add_student' do
     let!(:course) { Course.create(cis196_params) }
     let!(:student) { Student.create(first_name: 'First', last_name: 'Student') }

     before(:each) { visit "/courses/#{course.id}" }

     it 'redirects to the course\'s show page' do
       select student.full_name, from: 'student_id'
       click_button 'Add Student'
       expect(current_path).to eq("/courses/#{course.id}")
     end

     it 'loads the page successfully' do
       select student.full_name, from: 'student_id'
       click_button 'Add Student'
       expect(status_code).to eq(200)
     end

     it 'adds student to course\'s students' do
       select student.full_name, from: 'student_id'
       click_button 'Add Student'
       expect(course.students).to include(student)
     end

     it 'does not add student if student is already in course' do
       course.students << student
       select student.full_name, from: 'student_id'
       click_button 'Add Student'
       expect(course.students.size).to eq(1)
     end

     it 'still redirects if no student is selected' do
       click_button 'Add Student'
       expect(current_path).to eq("/courses/#{course.id}")
     end
  end

  describe '#delete_student' do
    let!(:course) { Course.create(cis196_params) }
    let!(:student) { course.students.create(first_name: 'First', last_name: 'Student') }

    before(:each) do
      visit "/courses/#{course.id}"
      find("a[href='/courses/#{course.id}/students/#{student.id}']").click
    end

    it 'redirects to the course\'s show page' do
      expect(current_path).to eq("/courses/#{course.id}")
    end

    it 'laods the page successfully' do
      expect(status_code).to eq(200)
    end

    it 'does not delete the student' do
      expect(page).to have_text(student.full_name)
    end

    it 'removes the student from the course' do
      expect(page).to_not have_text('Remove from course')
    end
  end
end
