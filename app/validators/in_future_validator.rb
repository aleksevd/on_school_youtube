class InFutureValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if value && value < Time.zone.now
      record.errors.add(attribute, (options[:message] || 'должно быть в будующем'))
    end
  end
end