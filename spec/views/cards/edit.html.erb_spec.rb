require 'rails_helper'

RSpec.describe "cards/edit", type: :view do
  before(:each) do
    @card = assign(:card, Card.create!(
      :list => nil,
      :name => "MyString",
      :position => 1
    ))
  end

  it "renders the edit card form" do
    render

    assert_select "form[action=?][method=?]", card_path(@card), "post" do

      assert_select "input#card_list_id[name=?]", "card[list_id]"

      assert_select "input#card_name[name=?]", "card[name]"

      assert_select "input#card_position[name=?]", "card[position]"
    end
  end
end
