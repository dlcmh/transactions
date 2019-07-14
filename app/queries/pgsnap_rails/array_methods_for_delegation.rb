module PgsnapRails
  module ArrayMethodsForDelegation
    # to handle calles from eg a view -> @some_instance_variable.each ...
    # https://github.com/nanoc/nanoc/issues/244#issuecomment-14071615
    # https://github.com/bobthecow/nanoc/blob/67ad983d3ea397862080b5a420a1fa07583ae97e/lib/nanoc/base/source_data/item_array.rb#L12
    ARRAY_METHODS_FOR_DELEGATION = %i[
      each
      find
      first
      last
      map
      present?
    ]
  end
end
