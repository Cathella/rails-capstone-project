class Transaction < ApplicationRecord
  validates :name, :amount, presence: true

  belongs_to :user
  belongs_to :group, optional: true

  s_str = 'transactions.name, transactions.id, transactions.amount, transactions.user_id, transactions.created_at'
  s_str2 = ', groups.icon, groups.name as gname'
  s_str3 = ''
  s_str4 = 'users.username as uname, sum(transactions.amount) as tot_amount'

  scope :grouped_display, ->(gid) { where(group_id: gid).joins(:group).joins(:user).select(s_str + s_str2) }
  scope :int_display, ->(uid) { where(user_id: uid).joins(:group).joins(:user).select(s_str + s_str2) }
  scope :ext_display, ->(uid) { where(user_id: uid, group_id: nil).joins(:user).select(s_str + s_str3) }
  scope :by_user, -> { joins(:user).select(s_str4).group(:uname) }
end
