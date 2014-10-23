class User < ActiveRecord::Base

  scope :active, ->() { where(active: true) }

  has_many :children,
           class_name: 'User',
           foreign_key: :parent_id,
           inverse_of: :parent

  belongs_to :parent,
             class_name: 'User',
             inverse_of: :children

  has_many :addresses,
           inverse_of: :user

  def self.x(user)
    active_children = user.children.active

    joins { active_children.as('active_users').on { id.in(active_users.id) }.outer }
      .select { ["users.*", active_users.id.as('calc_active')] }
  end

  def self.has_address
    joins { addresses }
  end

  def self.with_has_address
    a = User.has_address
    joins { a.as('addressable').on { id.eq(addressable.id) }.outer }
      .select { ["users.*", addressable.id.as('addressable')] }
  end
end
