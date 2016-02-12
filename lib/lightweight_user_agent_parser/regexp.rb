class LightweightUserAgentParser

  DEVICES_META = [

    [ :Android,        'Android|Adr'                     ],
    [ :iPod,           'iPod'                            ],
    [ :iPhone,         'iPhone|(iOS.*Smartphone)'        ],
    [ :iPad,           'iPad|(iOS.*Tablet)'              ],
    [ :BlackBerry,     'BlackBerry'                      ],
    [ :WindowsMobile,  'Windows *(Mobile|Phone)'         ],
    [ :Windows,        'Windows *(?:NT|9(?:5|8)|7|8|10)' ],
    [ :Symbian,        'Symbian|Opera Mini'              ],
    [ :FreeBSD,        'FreeBSD'                         ],
    [ :Linux,          'Linux'                           ],
    [ :Macintosh,      '(Mac *)?OS *X|Darwin'            ],
    [ :PlayStation,    'ps\d+'                           ],
    [ :Xbox,           'xbox(?: *(?:\w+|\d+))?'          ],
    [ :QuickTime,      'QuickTime'                       ],
    [ :Nintendo,       'Nintendo'                        ],
    [ :Bada,           'bada'                            ],
    [ :anonymized,     'anonymized'                      ]

  ]

  MOBILE_DEVICES = [
      :Android,
      :iPod,
      :iPhone,
      :iPad,
      :BlackBerry,
      :WindowsMobile,
      :Symbian,
      :Bada
  ]

  DESKTOP_DEVICES = DEVICES_META.map { |ary| ary[0] } - MOBILE_DEVICES

  DEVICES = DEVICES_META.map { |sym, regexp| [sym, {lazy: /#{regexp}/i, strict: /\b#{regexp}\b/i}] }.freeze

  module NameTable
    DEVICES.each do |type, regexp|
      define_singleton_method(type.to_s.downcase) { type }
    end
  end

  # Regex taken from http://detectmobilebrowsers.com
  mobile_file_content = File.read(File.join(File.dirname(__FILE__), 'mobile.txt')).split("\n")
  explicit_mobile_device_matcher = DEVICES_META.select { |ary| MOBILE_DEVICES.include?(ary[0]) }.map { |e| e[1] }.join('|')
  mobile_regexp_str = "#{mobile_file_content.join('|')}|#{explicit_mobile_device_matcher}"

  MOBILE_REGEXP = /#{mobile_regexp_str}/i.freeze

  desktop_device_matcher = DEVICES_META.select { |ary| DESKTOP_DEVICES.include?(ary[0]) }.map { |e| e[1] }.join('|')
  desktop_device_matcher << '|Mozilla/\d\.\d.*(compatible.*)'
  DESKTOP_REGEXP = /#{desktop_device_matcher}/i.freeze

  ANONYMIZED_REGEXP = Regexp.new(DEVICES_META.find { |sym, regex_str| sym == :anonymized }.last, Regexp::IGNORECASE)

end