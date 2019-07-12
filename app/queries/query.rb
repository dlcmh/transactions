class Query
  class Error < StandardError; end

  class << self
    def klass
      :Query
    end

    # allows for method chaining, in conjunction with the return of `self` in relevant methods
    # eg SomeQuery.limit(2).order(some_column: :asc)
    def method_missing(method, *args, &block)
      new.send(method, *args, &block)
    end

    # reload!; Query.profile { SomeQuery.new(User.find(3)).hashes }
    def profile(&block)
      start_memory = `ps -o rss= -p #{$$}`.to_i
      start_time = Time.zone.now
      output = yield
      memory_used = "Memory used: #{(`ps -o rss= -p #{$$}`.to_i - start_memory) / 1000} MB"
      elapsed_time = "Elapsed time: #{Time.zone.now - start_time} seconds"
      [
        output,
        memory_used,
        elapsed_time
      ]
    end
  end

  attr_reader :error, :opts

  # to handle calles from eg a view -> @some_instance_variable.each ...
  # https://github.com/nanoc/nanoc/issues/244#issuecomment-14071615
  # https://github.com/bobthecow/nanoc/blob/67ad983d3ea397862080b5a420a1fa07583ae97e/lib/nanoc/base/source_data/item_array.rb#L12
  delegate *%i[
    each
    find
    first
    last
    present?
  ], to: :open_structs

  def initialize
    @error = nil
    @opts = OpenStruct.new(combinations: [])
    from(query)
    construct unless opts.from
  end

  def all
    open_structs
  end

  def binds(hsh)
    opts.binds = (opts.binds || {}).merge(hsh)
    self
  end

  def columns
    current_limit = opts.limit ? opts.limit.scan(/(\d+)/).first.first : nil # get value for reset
    result = limit(0).results.columns
    current_limit.present? ? limit(current_limit) : opts.delete_field(:limit) # reset
    result
  end

  def combinations?
    opts.combinations.present?
  end

  # override in inheriting class
  # eg def construct; from(:users); end
  def construct; end

  def count
    size
  end

  def formatted_sql
    ActiveRecord::Base.sanitize_sql([sql, opts.binds])
  end

  def from(src)
    opts.from = sanitized(src)
    self
  end

  def hashes
    results.to_a
  end

  # for use in console, eg SomeTable.limit(2).order(some_column: :asc)
  # https://stackoverflow.com/questions/9520472/how-does-activerecord-detect-last-method-call-in-chain
  def inspect
    @inspect ||= error ? error : all.join("\n")
  end

  def klass
    self.class.klass
  end

  def limit(num = 1)
    opts.limit = "LIMIT #{num}"
    self
  end

  def maybe_raise_no_query_defined
    raise 'no query defined' unless opts.from
  end

  def modifiers?
    opts.limit.present? || opts.order.present? || opts.where.present?
  end

  def modifiers
    [opts.where, opts.order, opts.limit].compact.join(' ')
  end

  def open_structs
    hashes.map { |h| OpenStruct.new h }
  end

  def order(hsh)
    opts.order = "ORDER BY #{hsh.map { |ary| ary.join(' ') }.join(', ')}"
    self
  end

  def parenthesize(clause)
    "SELECT #{selected_columns} FROM (#{clause}) t0"
  end

  # override in inheriting class
  def query; end

  def results
    maybe_raise_no_query_defined
    ActiveRecord::Base.connection.select_all(formatted_sql, self.class.name)
  rescue => e
    msg = "<##{self.class.name}:#{object_id}>\n\n=> #{e}\n\n#{opts}"
    @error = msg
    raise Error, msg
  end

  def rows
    results.rows
  end

  def sanitized(src)
    return unless src
    if src.try(:klass) == :Query || src.try(:sql)
      src.sql.squish
    else
      src = src.to_s.squish
      if src.upcase.starts_with?('SELECT')
        src
      else
        "SELECT * FROM #{src}"
      end
    end
  end

  def select(*cols)
    opts.select = cols
    self
  end

  def select?
    opts.select.present?
  end

  def selected_columns
    select? ? "#{opts.select.join(', ')}" : '*'
  end

  def size
    rows.size
  end

  def sql
    maybe_raise_no_query_defined
    if !combinations? && !select? && !modifiers? # A
      return opts.from
    end
    if !combinations? && select? && !modifiers? # B
      return parenthesize(opts.from)
    end
    if !combinations? && modifiers? # Ca & Cb
      return "#{parenthesize(opts.from)} #{modifiers}"
    end
    if combinations? && !select? && !modifiers? # D
      return "(#{opts.from}) #{opts.combinations.join(' ')}"
    end
    if combinations? && select? && !modifiers? # E
      return parenthesize("(#{opts.from}) #{opts.combinations.join(' ')}")
    end
    if combinations? && modifiers? # Fa & Fb
      return [
        parenthesize("(#{opts.from}) #{opts.combinations.join(' ')}"),
        modifiers
      ].join(' ')
    end
  end

  def structs
    hashes.map do |h|
      Struct.new(*h.symbolize_keys!.keys).new(*h.values)
    end
  end

  def subquery
    "(#{sql})".squish
  end

  def to_s
    subquery
  end

  def union(src)
    opts.combinations << "UNION (#{sanitized(src)})"
    self
  end

  def union_all(src)
    opts.combinations << "UNION ALL (#{sanitized(src)})"
    self
  end

  def where(str)
    if opts.where
      opts.where = "#{opts.where} AND #{str}"
    else
      opts.where = "WHERE #{str}"
    end
    self
  end
end
