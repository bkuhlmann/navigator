module LayoutHelper
  def render_public_navigation
    navigation "nav" do
      a "Home", attributes: {href: root_path}
      a "News", attributes: {href: posts_path}
      a "Pages", attributes: {href: pages_path}
    end
  end
end
