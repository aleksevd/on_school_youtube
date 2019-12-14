module AdminHelper
  def render_flash
    %w(notice alert).
      select { |type| flash.key?(type) }.
      map { |type| flash_block(type) }.
      join.html_safe
  end

  private

  def flash_block(type)
    flash_classes = { notice: 'alert alert-success', alert: 'alert alert-danger' }
    content_tag(:div, class: flash_classes[type.to_sym]) do
      content_tag("button", "×", class: 'close clear', "data-dismiss" => "alert") + flash[type.to_sym]
    end
  end
end