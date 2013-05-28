module Library
  module Version
    MAJOR  = 0
    MINOR  = 4
    TINY   = 2
    NANO   = 0
    STRING = NANO > 0 ? [MAJOR, MINOR, TINY, NANO].join('.').freeze :  [MAJOR, MINOR, TINY].join('.').freeze
    TITLE  = "Bugfix".freeze
  end
  
  BuildNumber = 523

end

