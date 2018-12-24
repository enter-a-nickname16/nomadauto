require 'rails_helper'

RSpec.describe "lists/new", type: :view do
  before(:each) do
    assign(:list, List.new(
      :new => "MyString",
      :position => 1
    ))
  end

  it "renders new list form" do
    render

    assert_select "form[action=?][method=?]", lists_path, "post" do

      assert_select "input#list_new[name=?]", "list[new]"

      assert_select "input#list_position[name=?]", "list[position]"
    end
  end
end
