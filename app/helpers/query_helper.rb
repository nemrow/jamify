module QueryHelper
  def get_mix_downs_by_instrument(instrument, limit)
    full_mix_down_array = []
    mix_down_ids = MixDown.grab_by_instrument(instrument, limit)
    mix_down_ids.each do |mix_down|
      this_mix_down_hash = {}
      this_mix_down_hash['mix_down_sc_id'] = mix_down.sc_id
      this_mix_down_hash[:tracks] = mix_down.tracks.map {|track| track}
      full_mix_down_array << this_mix_down_hash
    end
    full_mix_down_array
  end
end