class RoleSwitchController < ApplicationController
  # check to see if the current action is allowed
  def action_allowed?
    # instructor,admin,superadmin is allowed to perform all the actions in
    # this controller
    ['Super-Administrator',
     'Administrator',
     'Instructor'].include? current_role_name
  end

  # sets student_view in session object and redirects to
  # student_task/list after updating menu list
  def open_student_view
    session[:student_view] = true
    role = Role.student
    session[:menu] = role.cache[:menu]
    redirect_to controller: 'student_task', action: 'list'
  end

  # closes student_view in session object and redirects to
  # tree_display/list after reverting the menu list as per the role
  def close_student_view
    session.delete(:student_view)
    role = Role.find(session[:user].role_id)
    session[:menu] = role.cache[:menu]
    redirect_to controller: 'tree_display', action: 'list'
  end
end
