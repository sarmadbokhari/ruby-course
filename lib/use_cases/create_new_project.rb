class TM::CreateProject

  def run(inputs)
    projects = Datbase.projects(inputs[:project_name])
    return failure(:project_does_not_exist) if task.nil?

    emp = DB.get_employee(inputs[:employee_id])
    return failure(:employee_does_not_exist) if emp.nil?

    # NOT SHOWN: Modify task to assign to employee

    # Return a success with relevant data
    success :task => task, :employee => emp
  end

end
