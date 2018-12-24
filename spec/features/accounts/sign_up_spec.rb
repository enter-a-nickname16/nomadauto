require "spec_helper"
require "rails_helper"

feature "Account" do
 scenario "creating an account" do
   visit root_path
   click_link "Sign up with Basic"
   fill_in "Name", with: "Test"
   click_button "Sign up"
 end
end