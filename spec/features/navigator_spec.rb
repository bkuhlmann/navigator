# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Site Navigation", type: :feature do
  it "As a visitor, I want a visual indication of which tab is active", :aggregate_failures do
    pending "Need to remove Slim gem."
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
