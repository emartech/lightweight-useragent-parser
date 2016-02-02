require_relative 'spec_helper'
module LightweightUseragentParser

  RSpec.describe Instance do

    let(:user_agent_string){TEST_DATA[0].dup}

    describe '#new' do

      context 'no argument string passed' do
        it 'should raise error' do
          expect{Instance.new}.to raise_error(ArgumentError)
        end
      end

      context 'with user agent string passed as argument' do

        it 'should make an instance' do
          expect(Instance.new(user_agent_string)).to be_instance_of Instance
        end

        it 'should happen too when we use the LightweightUseragentParser #new method what is a syntax sugar' do
          expect(LightweightUseragentParser.new(user_agent_string)).to be_instance_of Instance
        end

        test_cases = [
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
          }
        ]

        # (#{meta[:ua_str][0..60]}...)
        describe '#platform' do
          test_cases.each do |meta|
            if NameTable.respond_to?(meta[:platform].to_s.downcase)

              it "should be able to tell mobile: #{meta[:mobile]} and platform: #{meta[:platform]} by analyzing the user agent string" do
                expect(LightweightUseragentParser.new(meta[:ua_str]).platform.to_s).to eql meta[:platform]
              end

            end
          end
        end

        describe '#mobile?' do
          test_cases.each do |meta|
            if NameTable.respond_to?(meta[:platform].to_s.downcase)
              it "should be able to tell mobile: #{meta[:mobile]} and platform: #{meta[:platform]} by analyzing the user agent string" do
                expect(LightweightUseragentParser.new(meta[:ua_str]).mobile?).to eql meta[:mobile] if meta[:mobile]
              end
            end
          end
        end

        describe '#platform_by_followed_devices' do

          context 'when the parser encounter an already implemented user agent string format' do
            test_cases.each do |meta|

              if FOLLOWED_MOBILE_DEVICES.any?{|sym| sym.to_s =~ /^#{meta[:platform]}$/i }

                it 'should able to tell that the device is a followed device and specify the platform' do
                  agent = LightweightUseragentParser.new(meta[:ua_str])
                  expect(agent.platform_by_followed_devices.to_s).to eql meta[:platform]

                end

              else

                it 'should ignore the real platform and say :other as platform when the device platform is not in the followed device list' do
                  agent = LightweightUseragentParser.new(meta[:ua_str])
                  expect(agent.platform_by_followed_devices.to_s).to eql 'other'

                end

              end

            end
          end

          context 'when the input is a malformed or yet unknown user_agent string format' do

            it 'should raise an error to warn developers about unknown user agent form' do
              expect{LightweightUseragentParser.new('malformed user agent string').platform_by_followed_devices}.to raise_error ArgumentError
            end

          end

        end

      end

    end

  end

end
