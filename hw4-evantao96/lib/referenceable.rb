module Referenceable
  module InstanceMethods
    attr_reader :id

    def update(params)
      old_attributes = attributes
      assign_attributes(params)
      if valid?
        save
      else
        assign_attributes(old_attributes)
        false
      end
    end

    def save
      return false unless valid?
      set_up_new_instance unless id
      true
    end

    def persisted?
      !id.nil?
    end

    def new_record?
      !persisted?
    end
  end

  module ClassMethods
    attr_accessor :count
    attr_reader :all

    def add_id
      @last_id += 1
    end

    def find(id)
      all.detect { |instance| instance.id == id.to_i }
    end
  end
end
