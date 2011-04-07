class ShortUrl < ActiveRecord::Base
  ENCODING_MAPPING = ('0'..'9').to_a + ('a'..'z').to_a + ('A'..'Z').to_a
  
  validates_presence_of :url

  def url=(set_url)
    write_attribute(:url, PostRank::URI.clean(set_url))
  end

  def encoded_key
    raise 'Save record before requesting encoded_key' if id.blank?
    processed_id, output = id, ''
    
    while processed_id > 0
      output << ENCODING_MAPPING[processed_id % 62]
      processed_id /= 62
    end
    output.reverse
  end
  
  def self.find_from_encoded_key(key)
    return nil if key.blank?
    
    id_to_find = 0
    key.to_s.reverse.split('').each_with_index do |char, index|
      if ord = ENCODING_MAPPING.index(char)
        id_to_find += ord * (62 ** index)
      else
        raise ArgumentError, "#{key} has #{char} which is not valid"
      end
    end
    
    self.find(id_to_find)
  end
  

end