# frozen_string_literal: true

# Layout helpers for the view layer.
module LayoutHelper
  def render_public_navigation
    navigation "nav" do
      link "Home", root_path
      link "News", posts_path
      link "Pages", pages_path
    end
  end
end
