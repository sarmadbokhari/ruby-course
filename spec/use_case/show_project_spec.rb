require_relative "../spec_helper.rb"

describe TM::ShowProject do
  before do
    @db = TM.db
  end

  it "shows project with PID" do
    project1 = @db.create_project("HOMEWORK")
    project2 = @db.create_project("CHORES")

    result = subject.run({ :pid => project1.pid } )
    expect(result.success?).to eq true
    expect(result.project.name).to eq("HOMEWORK")
  end

  it "errors if no projects exist" do
    # project = @db.create_project("CHORES")

    result = subject.run({ :pid => 9999 } )
    expect(result.error?).to eq true
    expect(result.error).to eq :project
    _does_not_exist
  end

end
