require 'spec_helper'

describe SportsApi::Fetcher::Score::NBA do
  describe '#find' do
    context 'past game' do
      let(:date) { Date.new(2015, 10, 27) }
      let(:find) { SportsApi::Fetcher::Score::NBA.find(date) }
      let(:json_stub) { StubbedJson.get('past.json') }
      before { expect_any_instance_of(SportsApi::Fetcher::Score::NBA).to receive(:get).with('basketball', 'nba', dates: 20151027).and_return(json_stub) }
      context 'basic league info' do
        it { expect(find.calendar.size).to eq(184) }
        it { expect(find.name).to eq('National Basketball Association') }
      end
      context 'event info' do
        let(:event) { find.events.detect { |event| event.status.final? } }
        it { expect(event.date.to_date).to eq(Date.new(2015, 10, 28)) } #UTC time places this game on the 28th
        it { expect(event.competitors.first.location).to eq('Atlanta') }
        it { expect(event.competitors.first.name).to eq('Hawks') }
        it { expect(event.competitors.first.record.summary).to eq('0-1') }
        it { expect(event.score).to eq('94 - 106') }
        it { expect(event.status.final?).to be_truthy }
      end
    end

    describe 'pregame' do
      let(:date) { Date.new(2018, 04, 24) }
      let(:find) { SportsApi::Fetcher::Score::NBA.find(date) }
      let(:json_stub) { StubbedJson.get('pregame.json') }
      before { expect_any_instance_of(SportsApi::Fetcher::Score::NBA).to receive(:get).with('basketball', 'nba', dates: 20180424).and_return(json_stub) }
      context 'event info' do
        let(:event) { find.events.detect { |event| event.status.pregame? } }
        it { expect(event.status.detail).to eq("4/23 - 8:00 PM EDT") }
        it { expect(event.date.to_date).to eq(Date.new(2018, 04, 24)) }
        it { expect(event.competitors.first.location).to eq('Minnesota') }
        it { expect(event.competitors.first.name).to eq('Timberwolves') }
        it { expect(event.channel).to eq("TNT / AT&TSN / FSN") }
        it { expect(event.series_notes).to eq("HOU leads 2-1") }
      end
    end
  end
end
