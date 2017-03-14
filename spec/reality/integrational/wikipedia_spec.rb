require 'reality/data_sources/media_wiki'
require 'reality/definitions/wikipedia'

module Reality
  describe 'Entity from wikipedia', :integrational do
    describe '.wikipedia', :vcr do
      subject { Reality.wikipedia }

      it { is_expected.to be_a Reality::DataSources::MediaWiki }
    end

    describe 'Argentina', :vcr do
      subject(:entity) { Reality.wikipedia.find('Argentina') }

      it { is_expected.to be_an Entity }
      its(:inspect) { is_expected.to eq '#<Reality::Entity wikipedia:Argentina>' }

      context 'individual values' do
        subject { ->(n) { entity[n].first&.value } }

        its([:long_name]) { is_expected.to eq 'Argentine Republic' }
        its([:coord]) { is_expected.to eq Geo::Coord.new(latd: 34, latm: 36, lath: 'S', lngd: 58, lngm: 23, lngh: 'W') }
        its([:area]) { is_expected.to eq Measure[:km2].new(2_780_400) }
        its([:population]) { is_expected.to eq Measure[:person].new(43_417_000) }
        its([:capital]) { is_expected.to eq Link.new(:wikipedia, 'Buenos Aires') }
      end

      describe '#describe' do # (sic!)
        its(:describe) { is_expected.to eq %Q{
          #<Reality::Entity wikipedia:Argentina>
          |  long_name: Argentine Republic
          |      coord: -34.600000,-58.383333
          |       area: 2,780,400 km²
          | population: 43,417,000 person
          |    capital: wikipedia:Buenos Aires
        }}
      end
    end
  end
end
