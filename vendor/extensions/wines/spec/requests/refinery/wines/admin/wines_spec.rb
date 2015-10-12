# encoding: utf-8
require "spec_helper"

describe Refinery do
  describe "Wines" do
    describe "Admin" do
      describe "wines" do
        login_refinery_user

        describe "wines list" do
          before do
            FactoryGirl.create(:wine, :name_zh => "UniqueTitleOne")
            FactoryGirl.create(:wine, :name_zh => "UniqueTitleTwo")
          end

          it "shows two items" do
            visit refinery.wines_admin_wines_path
            page.should have_content("UniqueTitleOne")
            page.should have_content("UniqueTitleTwo")
          end
        end

        describe "create" do
          before do
            visit refinery.wines_admin_wines_path

            click_link "Add New Wine"
          end

          context "valid data" do
            it "should succeed" do
              fill_in "Name Zh", :with => "This is a test of the first string field"
              click_button "Save"

              page.should have_content("'This is a test of the first string field' was successfully added.")
              Refinery::Wines::Wine.count.should == 1
            end
          end

          context "invalid data" do
            it "should fail" do
              click_button "Save"

              page.should have_content("Name Zh can't be blank")
              Refinery::Wines::Wine.count.should == 0
            end
          end

          context "duplicate" do
            before { FactoryGirl.create(:wine, :name_zh => "UniqueTitle") }

            it "should fail" do
              visit refinery.wines_admin_wines_path

              click_link "Add New Wine"

              fill_in "Name Zh", :with => "UniqueTitle"
              click_button "Save"

              page.should have_content("There were problems")
              Refinery::Wines::Wine.count.should == 1
            end
          end

        end

        describe "edit" do
          before { FactoryGirl.create(:wine, :name_zh => "A name_zh") }

          it "should succeed" do
            visit refinery.wines_admin_wines_path

            within ".actions" do
              click_link "Edit this wine"
            end

            fill_in "Name Zh", :with => "A different name_zh"
            click_button "Save"

            page.should have_content("'A different name_zh' was successfully updated.")
            page.should have_no_content("A name_zh")
          end
        end

        describe "destroy" do
          before { FactoryGirl.create(:wine, :name_zh => "UniqueTitleOne") }

          it "should succeed" do
            visit refinery.wines_admin_wines_path

            click_link "Remove this wine forever"

            page.should have_content("'UniqueTitleOne' was successfully removed.")
            Refinery::Wines::Wine.count.should == 0
          end
        end

      end
    end
  end
end
