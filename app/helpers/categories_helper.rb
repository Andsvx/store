module CategoriesHelper
  def parent_id_options(category)
    parent_categories =
      if category.new_record?
        Category.all
      else
        Category.where.not("lft >= #{category.lft} AND rgt <= #{category.rgt}")
      end

    parent_categories
      .map { |parent_category| [parent_category.name, parent_category.id] }
      .unshift [t('common.text_no'), nil]
  end

  def build_tree(category)
    link = link_to category.name, category_path(category)

    if category.childs.empty?
      link
    else
      link + tag.ul(category.childs.map { |child| tag.li(build_tree(child)) }.join.html_safe)
    end
  end
end
