class Transaction < ApplicationRecord
  validates :name, :amount, presence: true

  belongs_to :user
  belongs_to :group, optional: true

  s_string = 'transactions.name, transactions.id, transactions.amount, transactions.user_id, transactions.created_at'
  s_string2 = ', groups.icon, groups.name as gname'
  s_string3 = ''
  s_string4 = 'users.username as uname, sum(transactions.amount) as tot_amount'

  scope :grouped_display, ->(gid) { where(group_id: gid).joins(:group).joins(:user).select(s_string + s_string2) }
  scope :int_display, ->(uid) { where(user_id: uid).joins(:group).joins(:user).select(s_string + s_string2) }
  scope :ext_display, ->(uid) { where(user_id: uid, group_id: nil).joins(:user).select(s_string + s_string3) }
  scope :by_user, -> { joins(:user).select(s_string4).group(:uname) }
end
