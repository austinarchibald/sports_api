require 'spec_helper'

describe SportsApi::Fetcher::Score::CBASE do
  describe '#find' do
    describe 'past game' do
      let(:date) { Date.new(2017, 3, 19) }
      let(:find) { SportsApi::Fetcher::Score::CBASE.find(date) }
      let(:json_stub) { StubbedJson.get('past.json') }
      before { expect_any_instance_of(SportsApi::Fetcher::Score::CBASE).to receive(:get).with('baseball', 'college-baseball', dates: 20170319).and_return(json_stub) }
      context 'basic league info' do
        it { expect(find.calendar.size).to eq(85) }
        it { expect(find.name).to eq('NCAA Men Baseball') }
        it { expect(find.start_date).to eq('2016-07-05T04:00Z') }
      end
      context 'event info' do
        let(:event) { find.events.detect { |event| event.status.final? } }
        it { expect(event.date.to_date).to eq(Date.new(2017, 3, 19)) }
        it { expect(event.competitors.first.name).to eq("Ragin' Cajuns") }
        it { expect(event.score).to eq('4 - 3') }
        it { expect(event.status.final?).to be_truthy }
      end
    end

    describe 'pregame' do
      let(:date) { Date.new(2017, 3, 21) }
      let(:find) { SportsApi::Fetcher::Score::CBASE.find(date) }
      let(:json_stub) { StubbedJson.get('pregame.json') }
      before { expect_any_instance_of(SportsApi::Fetcher::Score::CBASE).to receive(:get).with('baseball', 'college-baseball', dates: 20170321).and_return(json_stub) }

      context 'event' do
        let(:event) { find.events.detect { |event| event.status.pregame? } }
        it { expect(event.status.display_clock).to eq(nil) }
        it { expect(event.status.period).to eq('0') }
        it { expect(event.status.detail).to eq("3/21 - 4:00 PM EDT") }
        # it { expect(event.status.start_time).to eq(Time.new(2018, 3, 21, 14, 0, 0, '-06:00')) }
      end
    end
  end
end
