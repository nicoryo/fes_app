FactoryBot.define do
  factory :artist do
    name { 'TestArtist1' }
  end
  factory :artistA, class: Artist do
    id   {  'abc123' }
    name { 'ArstistA' }
    icon { '1' }
  end
end
