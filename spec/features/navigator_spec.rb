# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Site Navigation" do
  it "As a visitor, I want a visual indication of which tab is active", :aggregate_failures do
    visit root_path
    expect(all(".active").count).to eq(1)
    expect(find("a.active").text).to eq("Home")

    visit posts_path
    expect(all(".active").count).to eq(1)
    expect(find("a.active").text).to eq("News")

    visit pages_path
    expect(all(".active").count).to eq(1)
    expect(find("a.active").text).to eq("Pages")
  end
end
