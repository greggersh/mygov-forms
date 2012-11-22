require 'spec_helper'

describe "API", :type => :request do
  before do
    @sample_form_1 = Form.create!(:title => 'Sample Form 1', :number => 'S-1')
    @sample_form_2 = Form.create!(:title => 'Sample Form 2', :number => 'S-2')
    
    @sample_form_1.form_fields.create!(:field_type => "text", :name => 'text_field', :label => 'A Text Field', :description => 'This is a text field.')
    @sample_form_1.form_fields.create!(:field_type => "date", :name => 'date_field', :label => 'A Date Field', :description => 'This is a date field.')
    @sample_form_1.form_fields.create!(:field_type => "select", :name => 'select_field', :label => 'A Select Field', :description => 'This is a select field', :options => [['Yes', 'Yes'], ['No', 'No']])
  end

  describe "GET /api/forms" do    
    it "should return a JSON list of all the forms" do
      get "/api/forms"
      response.code.should == "200"
      parsed_json = JSON.parse(response.body)
      parsed_json.first.should == {"id" => 1, "title" => "Sample Form 1", "number" => 'S-1'}
      parsed_json.last.should == {"id" => 2, "title" => "Sample Form 2", "number" => 'S-2'}
    end
  end
  
  describe "GET /api/forms/:id" do
    it "should return a JSON representation of the form and all its fields" do
      get "/api/forms/#{@sample_form_1.id}"
      response.code.should == "200"
      parsed_json = JSON.parse(response.body)
      parsed_json["title"].should == "Sample Form 1"
      parsed_json["form_fields"].size.should == 3
      parsed_json["form_fields"].first["field_type"].should == "text"
    end
  end
  
  describe "POST /api/forms" do
    context "when valid form information is submitted" do
      it "should save the form as a submission" do
        post "/api/forms", {:form_id => @sample_form_1.id, :form => {:text_field => 'Test'}}
        response.code.should == "200"
        parsed_json = JSON.parse(response.body)
        parsed_json["status"].should == "OK"
        parsed_json["message"].should == "Your form was successfully submitted."
        parsed_json["submission_id"].should_not be_nil
      end
    end
    
    context "when no form id is submitted" do
      it "should return an error message" do
        post "/api/forms", {:form => {:text_field => 'Test'}}
        response.code.should == "406"
        parsed_json = JSON.parse(response.body)
        parsed_json["status"].should == "Error"
        parsed_json["message"].should == "Form submission invalid: missing form id"
      end
    end    
  end
end