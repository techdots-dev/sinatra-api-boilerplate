class User < Sequel::Model
  plugin :timestamps, update_on_create: true

  def validate
    super
    validates_presence [:name, :email]
    validates_unique :email
  end
end
