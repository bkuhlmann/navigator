# frozen_string_literal: true

require "rails_helper"

RSpec.feature "Site Navigation" do
  scenario "As a visitor, I want a visual indication of which tab is active" do
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
