module TestData

  # Generating the new lead name and surname
  #TODO-opinion Generating test data put to separate module so it is easy to maintain them.
  #TODO-opinion I may replace this with some random data gem, but this is not crucial in this test to have a nice data
  random_string = ('a'..'z').to_a.shuffle[0..3].join
  $new_lead_name = 'name_'+random_string
  $new_lead_surname = 'surname_'+random_string

end