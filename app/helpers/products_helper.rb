module ProductsHelper
  def render_product_status(product)
    if product.is_hidden
      content_tag(:span, "", :class => "fa fa-lock")
    else
      content_tag(:span, "", :class => "fa fa-globe")
    end
  end

  def render_highlight_content(product,query_string)
    excerpt_cont = excerpt(product.title, query_string, radius: 500)
    highlight(excerpt_cont, query_string)
  end

  def render_active(index)
    if index == 0
      "active"
    end
  end

  def render_unfavorite(product)
    !product.users.include?(current_user)
  end
end
