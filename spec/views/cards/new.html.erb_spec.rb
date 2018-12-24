require 'rails_helper'

RSpec.describe "cards/new", type: :view do
  before(:each) do
    assign(:card, Card.new(
      :list => nil,
      :name => "MyString",
      :position => 1
    ))
  end

  it "renders new card form" do
    render

    assert_select "form[action=?][method=?]", cards_path, "post" do

      assert_select "input#card_list_id[name=?]", "card[list_id]"

      assert_select "input#card_name[name=?]", "card[name]"

      assert_select "input#card_position[name=?]", "card[position]"
    end
  end
end
