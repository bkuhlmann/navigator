module LayoutHelper
  def render_public_navigation
    navigation "nav" do
      a "Home", href: root_path
      a "News", href: posts_path
      a "Pages", href: pages_path
    end
  end
end
