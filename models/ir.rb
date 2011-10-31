
class IR
  include Mongoid::Document
  field :data, :type => String, :default => ''
  field :name, :type => String, :default => ''
  def to_hash
    {
      :name => name,
      :data => data
    }
  end
end
