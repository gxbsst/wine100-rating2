# encoding: utf-8
require "spec_helper"

describe Refinery do
  describe "TestPapers" do
    describe "Admin" do
      describe "test_papers" do
        login_refinery_user

        describe "test_papers list" do
          before do
            FactoryGirl.create(:test_paper, :score => "UniqueTitleOne")
            FactoryGirl.create(:test_paper, :score => "UniqueTitleTwo")
          end

          it "shows two items" do
            visit refinery.test_papers_admin_test_papers_path
            page.should have_content("UniqueTitleOne")
            page.should have_content("UniqueTitleTwo")
          end
        end

        describe "create" do
          before do
            visit refinery.test_papers_admin_test_papers_path

            click_link "Add New Test Paper"
          end

          context "valid data" do
            it "should succeed" do
              fill_in "Score", :with => "This is a test of the first string field"
              click_button "Save"

              page.should have_content("'This is a test of the first string field' was successfully added.")
              Refinery::TestPapers::TestPaper.count.should == 1
            end
          end

          context "invalid data" do
            it "should fail" do
              click_button "Save"

              page.should have_content("Score can't be blank")
              Refinery::TestPapers::TestPaper.count.should == 0
            end
          end

          context "duplicate" do
            before { FactoryGirl.create(:test_paper, :score => "UniqueTitle") }

            it "should fail" do
              visit refinery.test_papers_admin_test_papers_path

              click_link "Add New Test Paper"

              fill_in "Score", :with => "UniqueTitle"
              click_button "Save"

              page.should have_content("There were problems")
              Refinery::TestPapers::TestPaper.count.should == 1
            end
          end

        end

        describe "edit" do
          before { FactoryGirl.create(:test_paper, :score => "A score") }

          it "should succeed" do
            visit refinery.test_papers_admin_test_papers_path

            within ".actions" do
              click_link "Edit this test paper"
            end

            fill_in "Score", :with => "A different score"
            click_button "Save"

            page.should have_content("'A different score' was successfully updated.")
            page.should have_no_content("A score")
          end
        end

        describe "destroy" do
          before { FactoryGirl.create(:test_paper, :score => "UniqueTitleOne") }

          it "should succeed" do
            visit refinery.test_papers_admin_test_papers_path

            click_link "Remove this test paper forever"

            page.should have_content("'UniqueTitleOne' was successfully removed.")
            Refinery::TestPapers::TestPaper.count.should == 0
          end
        end

      end
    end
  end
end
