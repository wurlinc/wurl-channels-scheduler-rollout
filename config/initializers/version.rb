module Wurl
  class Platform
    HEAP_SLOT_SIZE = GC::INTERNAL_CONSTANTS[:RVALUE_SIZE]
    HEAP_SLOTS_PER_PAGE = GC::INTERNAL_CONSTANTS[:HEAP_OBJ_LIMIT]

    # TODO Set it, read it from a file, etc.
    VERSION = '2.4.10'

    REVISION = File.directory?(Rails.root.join('.git')) ? `git rev-parse HEAD` : ""

    BRANCH   =  File.directory?(Rails.root.join('.git')) ? `git branch | grep \\* | cut -d ' ' -f2` : ""

    GEMS = `gem list`.split("\n")

    NODE_PACKAGES = `npm list --depth 0 2> /dev/null`.split(/\n.* /)[1..-1]

    def self.comma_format(number, add_decimals=true)
      add_decimals ? sprintf("%0.2f", number).gsub(/(\d)(?=\d{3}+\.)/, '\1,')
                   : sprintf("%0.2f", number).gsub(/(\d)(?=\d{3}+\.)/, '\1,').gsub(/(.*)\.(.*)/, '\1')
    end

    def self.mb(number)
      (number.to_f / 1024) / 1024
    end

    def self.memory_report
      {
        'Total RAM Allocated (Mb)':
          comma_format(mb(GC.stat[:heap_allocated_pages] * Wurl::Platform::HEAP_SLOT_SIZE)),
        'Free RAM in Ruby heap (Mb)':
          comma_format(mb(GC.stat[:heap_free_slots] * Wurl::Platform::HEAP_SLOT_SIZE)),
      }
    end

  end
end
