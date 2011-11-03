
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

  def IR.validate_name(name, on_invalid)
    valid = name.gsub(/^\//,'').gsub(/\/$/,'').gsub(/[^#{@@conf['ir_name_regexp']}]/,'')
    on_invalid.call(valid) if valid != name
    return valid
  end
end
