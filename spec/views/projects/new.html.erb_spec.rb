require 'rails_helper'

RSpec.describe "projects/new", type: :view do
  before(:each) do
    assign(:project, Project.new(
      :title => "MyString",
      :details => "MyString",
      :users => nil
    ))
  end

  it "renders new project form" do
    render

    assert_select "form[action=?][method=?]", projects_path, "post" do

      assert_select "input#project_title[name=?]", "project[title]"

      assert_select "input#project_details[name=?]", "project[details]"

      assert_select "input#project_users_id[name=?]", "project[users_id]"
    end
  end
end
