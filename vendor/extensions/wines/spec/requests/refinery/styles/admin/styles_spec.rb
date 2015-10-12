# encoding: utf-8
require "spec_helper"

describe Refinery do
  describe "Styles" do
    describe "Admin" do
      describe "styles" do
        login_refinery_user

        describe "styles list" do
          before do
            FactoryGirl.create(:style, :name => "UniqueTitleOne")
            FactoryGirl.create(:style, :name => "UniqueTitleTwo")
          end

          it "shows two items" do
            visit refinery.styles_admin_styles_path
            page.should have_content("UniqueTitleOne")
            page.should have_content("UniqueTitleTwo")
          end
        end

        describe "create" do
          before do
            visit refinery.styles_admin_styles_path

            click_link "Add New Style"
          end

          context "valid data" do
            it "should succeed" do
              fill_in "Name", :with => "This is a test of the first string field"
              click_button "Save"

              page.should have_content("'This is a test of the first string field' was successfully added.")
              Refinery::Styles::Style.count.should == 1
            end
          end

          context "invalid data" do
            it "should fail" do
              click_button "Save"

              page.should have_content("Name can't be blank")
              Refinery::Styles::Style.count.should == 0
            end
          end

          context "duplicate" do
            before { FactoryGirl.create(:style, :name => "UniqueTitle") }

            it "should fail" do
              visit refinery.styles_admin_styles_path

              click_link "Add New Style"

              fill_in "Name", :with => "UniqueTitle"
              click_button "Save"

              page.should have_content("There were problems")
              Refinery::Styles::Style.count.should == 1
            end
          end

        end

        describe "edit" do
          before { FactoryGirl.create(:style, :name => "A name") }

          it "should succeed" do
            visit refinery.styles_admin_styles_path

            within ".actions" do
              click_link "Edit this style"
            end

            fill_in "Name", :with => "A different name"
            click_button "Save"

            page.should have_content("'A different name' was successfully updated.")
            page.should have_no_content("A name")
          end
        end

        describe "destroy" do
          before { FactoryGirl.create(:style, :name => "UniqueTitleOne") }

          it "should succeed" do
            visit refinery.styles_admin_styles_path

            click_link "Remove this style forever"

            page.should have_content("'UniqueTitleOne' was successfully removed.")
            Refinery::Styles::Style.count.should == 0
          end
        end

      end
    end
  end
end
