module TM
  class ShowProject < UseCase

    def run(inputs)
      project = TM.db.get_project(inputs[:pid])
      return failure(:project_does_not_exist) if project.nil?

      success :project => project
    end

  end
end

# result = TM::ShowProject.run({:pid => 3})
# result = success({:project => "proj_with_id3"})

# result.project
# #=> "proj_with_id3"
