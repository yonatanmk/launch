describe ReportWorker do

  describe 'scheduling' do
    it 'will be scheduled hourly' do
      valid, invalid = times

      expect( next_occurrence ).to eq(valid)
      expect( next_occurrence ).not_to eq(invalid)

      Timecop.freeze(Time.zone.now + 1.hour)

      # Testing the past time is no longer valid
      expect( next_occurrence ).not_to eq(valid)

      valid, invalid = times(2.hours)

      expect( next_occurrence ).to eq(valid)
      expect( next_occurrence ).not_to eq(invalid)
    end
  end

  def next_occurrence
    ReportWorker.schedule.next_occurrence
  end

  def times(offset = 1.hour)
    valid = Time.zone.now.beginning_of_hour + 1.hour
    invalid = valid + 1.minute

    [valid, invalid]
  end

end
