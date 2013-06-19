#!/bin/env ruby
# encoding: utf-8
require 'spec_helper'

describe APIv1::Unlocks do
 include Rack::Test::Methods

  def app
    APIv1::Unlocks
  end

  before(:all) do
    (1..3).to_a.each do |n|
      FactoryGirl.create :unlock, name: "Unlock #{n}"
    end
    I18n.locale = :jp
    Unlock.first.update_attributes({ name: "アンロック 1", description: 'これは説明です' })
    I18n.locale = :en      
  end

  describe "with params[:locale]" do
    describe "GET /v1/unlocks/" do
      it "returns unlocks with translations if exist" do
        get "/v1/unlocks.json", { locale: 'jp' }
        response_data.to_a.map{|c| c["name"]}.should include('アンロック 1')
        # the other Unlocks should fallback to English
        response_data.to_a.map{|c| c["name"]}.should include('Unlock 2')
        response_data.to_a.map{|c| c["name"]}.should include('Unlock 3')
        response_data.to_a.size.should eql 3
      end

      it "returns unlocks with :en if no translations exist" do
        get "/v1/unlocks.json", { locale: 'ru' }
        response_data.to_a.map{|c| c["name"]}.should_not include('アンロック 1')
        response_data.to_a.map{|c| c["description"]}.should_not include('これは説明です')
        found = response_data.to_a.find { |n| n['name'] == 'Unlock 1' }
        found["name"].should eql "Unlock 1"
      end        
    end

    describe "GET /v1/unlocks/1" do
      it "returns unlock translated with params[:locale] set" do
        get "/v1/unlocks/#{Unlock.first.id}.json", { locale: 'jp' }
        response_data["name"].should eql "アンロック 1"
        response_data["description"].should eql "これは説明です"
      end      
    end
  end


end