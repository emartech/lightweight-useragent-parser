require 'spec_helper'

RSpec.describe LightweightUserAgentParser do

  TEST_CASES = [

      {
          ua_str: '',
          mobile: false,
          platform: 'other'
      },
      {
          ua_str: 'UCWEB/2.0 (Linux; U; Adr 4.2.1; zh-CN; Lenovo A3000) U2/1.0.0 UCBrowser/9.8.5.442 U2/1.0.0 Mobile',
          mobile: true,
          platform: 'Android'
      },
      {
          ua_str: 'Opera/9.80 (Android; Opera Mini/6.1.25375/35.3730; U; ru) Presto/2.8.119 Version/11.10',
          mobile: true,
          platform: 'Android'
      },
      {
          ua_str: 'Mozilla/5.0 (iPod; U; CPU iPhone OS 4_2_1 like Mac OS X; pt-br) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8C148 Safari/6533.18.5',
          mobile: true,
          platform: 'iPod'
      },
      {
          ua_str: 'Mozilla/5.0 (iPhone; CPU iPhone OS 8_0_2 like Mac OS X) AppleWebKit/600.1.4 (KHTML, like Gecko) Version/8.0 Mobile/12A405 Safari/600.1.4 BMID/E67A2870D2',
          mobile: true,
          platform: 'iPhone'
      },
      {
          ua_str: 'Mozilla/5.0 (iPad; CPU OS 7_1 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) GSA/3.2.0.25255 Mobile/11D167 Safari/8536.25',
          mobile: true,
          platform: 'iPad'
      },
      {
          ua_str: 'BlackBerry8110/4.5.0.180 Profile/MIDP-2.0 Configuration/CLDC-1.1 VendorID/102',
          mobile: true,
          platform: 'BlackBerry'
      },
      {
          ua_str: 'Mozilla/4.0 (compatible; MSIE 7.0; Windows Phone OS 7.0; Trident/3.1; IEMobile/7.0; CHERRY; MOBILE Alpha Style)',
          mobile: true,
          platform: 'WindowsMobile'
      },
      {
          ua_str: 'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.1; WOW64; Trident/7.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; Media Center PC 6.0; .NET4.0C; .NET4.0E; AlexaToolbar/amzni-3.0; BRI/2; Microsoft Outlook 15.0.4605; ms-office; MSOffice 15)',
          mobile: false,
          platform: 'Windows'
      },
      {
          ua_str: 'Opera/9.80 (J2ME/MIDP; Opera Mini/4.2.14069/35.5003; U; uk) Presto/2.8.119 Version/11.10',
          mobile: true,
          platform: 'Symbian'
      },
      {
          ua_str: 'Mozilla/5.0 (X11; FreeBSD i386) AppleWebKit/535.19 (KHTML, like Gecko) Chrome/18.0.1025.162 Safari/535.19',
          mobile: false,
          platform: 'FreeBSD'
      },
      {
          ua_str: 'Mozilla/5.0 (X11; U; Linux i686; pt-BR; rv:1.9.0.19) Gecko/2010040116 Ubuntu/9.04 (jaunty) Firefox/3.0.19',
          mobile: false,
          platform: 'Linux'
      },
      {
          ua_str: 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:29.0) Gecko/20100101 Firefox/29.0 AlexaToolbar/p1VF2_Uf-2.1',
          mobile: false,
          platform: 'Macintosh'
      },
      {
          ua_str: 'Mozilla/5.0 (SAMSUNG; SAMSUNG-GT-S5330/1.0; U; Bada/1.0; pt-br) AppleWebKit/533.1 (KHTML, like Gecko) Dolfin/2.0 Mobile WQVGA SMM-MMS/1.2.0 OPN-B',
          mobile: true,
          platform: 'Bada'
      },
      {
          ua_str: 'Firefox/33.1 (x86 de); anonymized by Abelssoft 2048434593',
          mobile: false,
          platform: 'anonymized'
      },
      {
          ua_str: 'Mozilla/4.0 (compatible;)',
          mobile: false,
          platform: 'other'
      }
  ]

  let(:user_agent_string) { TEST_DATA[rand(0..(TEST_DATA.length-1))].dup }

  describe '#initialize' do
    subject { described_class.new(*args) }

    context 'no argument string passed' do
      let(:args) { [] }

      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'with user agent string passed as argument' do
      let(:args) { [user_agent_string] }

      it { is_expected.to be_instance_of described_class }
    end

  end

  describe '#platform' do
    subject { described_class.new(ua_str).platform.to_s }
    TEST_CASES.each do |meta|

      context "when platform is #{meta[:platform]}" do
        let(:ua_str) { meta[:ua_str] }

        it { is_expected.to eql meta[:platform] }
      end

    end
  end

  describe '#is_mobile?' do
    subject { described_class.new(ua_str).is_mobile? }
    TEST_CASES.each do |meta|

      context "when platform is #{meta[:platform]}" do

        context "and the user agent string is: #{meta[:ua_str].inspect}" do
          let(:ua_str) { meta[:ua_str] }

          it "then the mobile state should be #{meta[:mobile]}" do
            is_expected.to eq meta[:mobile]
          end
        end

      end

    end
  end

  describe '#to_hash' do
    subject { described_class.new(user_agent_string).to_hash }

    TEST_CASES.each do |meta|

      context "when user agent string is: #{meta[:ua_str].inspect}" do
        let(:user_agent_string) { meta[:ua_str] }

        it 'should parse platform and mobile state' do

          expected_hash = {
              mobile: meta[:mobile],
              platform: meta[:platform].to_sym,
              md5: Digest::MD5.hexdigest(meta[:ua_str]),
              anonymized: meta[:ua_str].include?('anonymized') ? true : false
          }

          is_expected.to eq expected_hash

        end
      end

    end

  end

  describe '#md5' do
    subject{ described_class.new(user_agent_string).md5}
    let(:user_agent_string){'UCWEB/2.0 (Linux; U; Adr 4.2.1; zh-CN; Lenovo A3000) U2/1.0.0 UCBrowser/9.8.5.442 U2/1.0.0 Mobile'}

    it { is_expected.to eq '50e330f013751df448e496bc19def744' }
  end

end