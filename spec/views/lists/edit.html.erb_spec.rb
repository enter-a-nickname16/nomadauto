require 'rails_helper'

RSpec.describe "lists/edit", type: :view do
  before(:each) do
    @list = assign(:list, List.create!(
      :new => "MyString",
      :position => 1
    ))
  end

  it "renders the edit list form" do
    render

    assert_select "form[action=?][method=?]", list_path(@list), "post" do

      assert_select "input#list_new[name=?]", "list[new]"

      assert_select "input#list_position[name=?]", "list[position]"
    end
  end
end
