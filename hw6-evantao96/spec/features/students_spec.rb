require 'rails_helper'

RSpec.feature "Students", type: :feature do
  let!(:student1_first_name) { 'First' }
  let!(:student1_last_name) { 'Student1' }
  let!(:student1_full_name) { "#{student1_first_name} #{student1_last_name}" }
  let!(:student1_params) { { first_name: student1_first_name, last_name: student1_last_name } }

  let!(:student2_first_name) { 'Second' }
  let!(:student2_last_name) { 'Student2' }
  let!(:student2_full_name) { "#{student2_first_name} #{student2_last_name}" }
  let!(:student2_params) { { first_name: student2_first_name, last_name: student2_last_name } }

  describe '#index' do
    before(:each) do
      Student.create(student1_params)
      Student.create(student2_params)
      visit '/students'
    end

    it 'loads the page successfully' do
      expect(status_code).to eq(200)
    end

    it 'lists all student names' do
      expect(page).to have_text(student1_full_name)
      expect(page).to have_text(student2_full_name)
    end

    it 'has edit links for each student' do
      expect(page).to have_selector('a i.fa-pencil', count: 2)
    end

    it 'has delete links for each student' do
      expect(page).to have_selector('a i.fa-trash', count: 2)
    end

    it 'has a new student link' do
      expect(page).to have_selector('a', text: 'New Student')
    end
  end

  describe '#show' do
    let!(:student) { Student.create(student1_params) }
    let!(:course) { student.courses.create(title: 'CIS 196', description: 'Ruby on Rails Web Development') }
    before(:each) { visit "/students/#{student.id}" }

    it 'loads the page successfully' do
      expect(status_code).to eq(200)
    end

    it 'has the name of the chosen student' do
      expect(page).to have_text(student.full_name)
    end

    it 'lists the current courses' do
      expect(page).to have_selector('a', text: course.title)
    end
  end

  describe '#new' do
    before(:each) { visit '/students/new' }

    it 'loads the page successfully' do
      expect(status_code).to eq(200)
    end

    it 'has first name field' do
      expect(page).to have_field('student_first_name')
    end

    it 'has last name field' do
      expect(page).to have_field('student_last_name')
    end
  end

  describe '#edit' do
    let!(:student) { Student.create(student1_params) }
    before(:each) { visit "/students/#{student.id}/edit" }

    it 'laods the page successfully' do
      expect(status_code).to eq(200)
    end

    it 'has the first name of the student to be edited' do
      expect(page).to have_text(student.first_name)
    end

    it 'has the last name of the student to be edited' do
      expect(page).to have_text(student.last_name)
    end
  end

  describe '#create' do
    before(:each) do
      Student.delete_all
      visit '/students/new'
      fill_in 'student_first_name', with: student1_first_name
      fill_in 'student_last_name', with: student1_last_name
      click_button 'Create Student'
    end

    it 'redirects to new student' do
      expect(current_path).to eq('/students/1')
    end

    it 'loads the page successfully' do
      expect(status_code).to eq(200)
    end

    it 'has first name of newly created student' do
      expect(page).to have_text(student1_first_name)
    end

    it 'has the last name of newly created student' do
      expect(page).to have_text(student1_last_name)
    end
  end

  describe '#update' do
    let(:student) { Student.create(student1_params) }

    before(:each) do
      visit "/students/#{student.id}/edit"
      fill_in 'student_first_name', with: student2_first_name
      fill_in 'student_last_name', with: student2_last_name
      click_button 'Update Student'
    end

    it 'redirects to the student show page' do
      expect(current_path).to eq("/students/#{student.id}")
    end

    it 'loads the page successfully' do
      expect(status_code).to eq(200)
    end

    it 'does not have the first name of the student before udpate' do
      expect(page).to_not have_text(student1_first_name)
    end

    it 'does not have the last name of the student before update' do
      expect(page).to_not have_text(student1_last_name)
    end

    it 'has the first name of the student after update' do
      expect(page).to have_text(student2_first_name)
    end

    it 'has the last name of the student after update' do
      expect(page).to have_text(student2_last_name)
    end
  end

  describe '#destroy' do
    let!(:student) { Student.create(student1_params) }

    before(:each) { visit "/students/#{student.id}" }

    it 'has the first name of the student before delete' do
      expect(page).to have_text(student1_first_name)
    end

    it 'has the last name of the student before delete' do
      expect(page).to have_text(student1_last_name)
    end

    context 'when delete button is pressed' do
      before(:each) { find("a[href='/students/#{student.id}']").click }

      it 'redirects to student index page' do
        expect(current_path).to eq('/students')
      end

      it 'loads the page successfully' do
        expect(status_code).to eq(200)
      end

      it 'does not have the first name of the deleted student' do
        expect(page).to_not have_text(student1_first_name)
      end

      it 'does not have the last name of the deleted student' do
        expect(page).to_not have_text(student1_last_name)
      end
    end
  end

  describe '#add_course' do
    let!(:student) { Student.create(student1_params) }
    let!(:course) { Course.create(title: 'CIS 196', description: 'Ruby on Rails Web Development') }

    before(:each) { visit "/students/#{student.id}" }

    it 'redirects to the student\'s show page' do
      select course.title, from: 'course_id'
      click_button 'Add Course'
      expect(current_path).to eq("/students/#{student.id}")
    end

    it 'loads the page successfully' do
      select course.title, from: 'course_id'
      click_button 'Add Course'
      expect(status_code).to eq(200)
    end

    it 'adds course to student\'s courses' do
      select course.title, from: 'course_id'
      click_button 'Add Course'
      expect(student.courses).to include(course)
    end

    it 'does not add course if course is already in student' do
      student.courses << course
      select course.title, from: 'course_id'
      click_button 'Add Course'
      expect(student.courses.size).to eq(1)
    end

    it 'still redirects if no course is selected' do
      click_button 'Add Course'
      expect(current_path).to eq("/students/#{student.id}")
    end
  end

  describe '#delete_course' do
    let!(:student) { Student.create(student1_params) }
    let!(:course) { student.courses.create(title: 'CIS 196', description: 'Ruby on Rails Web Development') }

    before(:each) do
      visit "/students/#{student.id}"
      find("a[href='/students/#{student.id}/courses/#{course.id}']").click
    end

    it 'redirects to the student\'s show page' do
      expect(current_path).to eq("/students/#{student.id}")
    end

    it 'loads the page successfully' do
      expect(status_code).to eq(200)
    end

    it 'does not delete the course' do
      expect(page).to have_text(course.title)
    end

    it 'removes the course from the student' do
      expect(page).to_not have_text('Remove course from schedule')
    end
  end
end
