class PhoneNumber
  attr_accessor :id, :label, :number

  def id
    @id
  end

  def label
    @label
  end

  def number
    @number
  end

  def to_s
    "ID: #{id} #{label}: #{number}"
  end
end
