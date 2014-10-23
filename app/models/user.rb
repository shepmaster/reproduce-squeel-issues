class User < ActiveRecord::Base

  scope :active, ->() { where(active: true) }

  has_many :children,
           class_name: 'User',
           foreign_key: :parent_id,
           inverse_of: :parent

  belongs_to :parent,
             class_name: 'User',
             inverse_of: :children

  def self.x(user)
    active_children = user.children.active

    joins { active_children.as('active_users').on { id.in(active_users.id) }.outer }
      .select { ["users.*", active_users.id.as('calc_active')] }
  end
end
