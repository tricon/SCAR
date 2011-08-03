class ActiveRecord::Base
  def as_json(options)
    hash = super(options)
    self.class.reflect_on_all_associations.each do |assoc|
      assoc_records = self.send(assoc.name)
      if !assoc_records.blank?
        if assoc_records.class == Array
          id_field = '_ids'
          assoc_record_ids = assoc_records.map { |ar| ar.id }
        else
          id_field = '_id'
          assoc_record_ids = assoc_records.id
        end
        hash.merge!({ "#{assoc.name.to_s}#{id_field}" => assoc_record_ids })
      end
    end
    hash
  end
end