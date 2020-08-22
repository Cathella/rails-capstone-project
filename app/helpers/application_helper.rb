module ApplicationHelper
  def group_is_empty?(id)
    return 'd-none' unless Transaction.grouped_display(id).first.nil?
  end
end
