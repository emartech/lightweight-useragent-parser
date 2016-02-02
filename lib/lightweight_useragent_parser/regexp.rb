module LightweightUseragentParser

  DEVICES_META = [

    [ :Android,        'Android|Adr'              ],
    [ :iPod,           'iPod'                     ],
    [ :iPhone,         'iPhone|(iOS.*Smartphone)' ],
    [ :iPad,           'iPad|(iOS.*Tablet)'       ],
    [ :BlackBerry,     'BlackBerry'               ],
    [ :WindowsMobile,  'Windows *(Mobile|Phone)'  ],
    [ :Windows,        'Windows(?: +NT)?'         ],
    [ :Symbian,        'Symbian|Opera Mini'       ],
    [ :FreeBSD,        'FreeBSD'                  ],
    [ :Linux,          'Linux'                    ],
    [ :Macintosh,      '(Mac *)?OS *X|Darwin'     ],
    [ :PlayStation,    'ps\d+'                    ],
    [ :Xbox,           'xbox(?: *(?:\w+|\d+))?'   ],
    [ :QuickTime,      'QuickTime'                ],
    [ :Nintendo,       'Nintendo'                 ],
    [ :Bada,           'bada'                     ],
    [ :anonymized,     'anonymized'               ]

  ]

  DEVICES = DEVICES_META.map{ |sym,regexp| [sym,{ lazy: /#{regexp}/i, strict: /\b#{regexp}\b/i } ] }.freeze

  FOLLOWED_MOBILE_DEVICES = [
    :Android,
    :iPhone,
    :iPad,
    :BlackBerry,
    :WindowsMobile,
    :Symbian
  ]

  module NameTable
    DEVICES.each do |type,regexp|
      define_singleton_method(type.to_s.downcase){type}
    end
  end

  # Regex taken from http://detectmobilebrowsers.com
  MOBILE_REGEXP = /#{File.read(File.join(File.dirname(__FILE__),'mobile.txt')).split("\n").join('|')}|#{DEVICES_META.select{
    |ary| FOLLOWED_MOBILE_DEVICES.include?(ary[0])}.map{|e|e[1]}.join('|')}/i.freeze

end