require 'pygments'

module ApplicationHelper

  def title
    "Shelved | #{controller.controller_name.titleize} | #{controller.action_name.titleize}"
  end

  def nav_item(text, link)
    if (%W[books authors publishers].include?(controller.controller_name) && text == 'Books') || (%W[discs artists labels genres disc_formats].include?(controller.controller_name) && text == 'Music') || (%W[sessions].include?(controller.controller_name) && text == 'Log In') then
      css_class = 'active'
    else
      css_class = ''
    end
    content_tag :li, link_to(text, link), :class => css_class
  end
  
  def render_sub_nav
    if %W[books authors publishers].include?(controller.controller_name)
      render 'layouts/nav_books'
    elsif %W[discs artists labels genres disc_formats].include?(controller.controller_name)
      render 'layouts/nav_music'
    end
  end

  class HTMLwithPygments < Redcarpet::Render::HTML
    def block_code(code, language)
      Pygments.highlight(code, :lexer => language)
    end
  end

  def markdown(text)
    renderer = HTMLwithPygments.new(:hard_wrap => true)
    options = {
      :fenced_code_blocks => true,
      :no_intra_emphasis => true,
      :autolink => true,
      :strikethrough => true,
      :lax_html_blocks => true,
      :superscript => true
    }
    Redcarpet::Markdown.new(renderer, options).render(text).html_safe
  end
  
end
