require "rails_helper"

 feature "Projects" do
 let!(:user_a) { FactoryGirl.create(:user) }
 let!(:user_b) { FactoryGirl.create(:user) }

 before do
 FactoryGirl.create(:project, title: "Account A's Book", user: account_a)
 FactoryGirl.create(:project, title: "Account B's Book", user: account_b)
 end

 context "index" do
 scenario "displays only account A's book" do
 set_subdomain(user_a.subdomain)
 login_as(user_a.owner)
 visit root_url
 expect(page).to have_content("Account A's Book")
 expect(page).to_not have_content("Account B's Book")
 end

 scenario "displays only account B's book" do
 Applying account scoping 112
 set_subdomain(account_b.subdomain)
 login_as(user_b.owner)
 visit root_url
 expect(page).to have_content("Account B's Book")
 expect(page).to_not have_content("Account A's Book")
 end
 end
end