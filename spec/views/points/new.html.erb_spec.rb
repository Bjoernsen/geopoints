require 'spec_helper'

describe "points/new" do
  before(:each) do
    assign(:point, stub_model(Point).as_new_record)
  end

  it "renders new point form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", points_path, "post" do
    end
  end
end
