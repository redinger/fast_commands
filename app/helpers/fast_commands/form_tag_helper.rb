module FastCommands::FormTagHelper
  def check_box_for_bulk_action(name, bulk_item, item)
    checked = !bulk_item.checked.nil? && bulk_item.checked.include?(item.id.to_s)
    check_box_tag name, item.id, checked, :id => dom_id(item)
  end
end
