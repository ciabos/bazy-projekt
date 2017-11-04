require 'faker'

prisoners = []
blocks = []
sentences = []
crimes_in_sentences = []
resources = []

RESOURCE_TYPES = ['have_to', 'should_have', 'can_have']
THREAT_TYPES = ['red', 'yellow', 'green', 'white']
CRIME_TYPES = ['light', 'medium', 'heavy']
PASS_TYPES = ['dayily_check', 'weekly_check', 'monthly_check']

CRIME_TYPES.each_with_index do |type, i|
  Crime.create!(crime_type: type, penalty: (i+1)*10)
end

THREAT_TYPES.each do |type|
  blocks << Block.create!(threat: type)
end
blocks.each do |block|
  40.times do
    Cell.create!(capacity: rand(1..5), block: block)
  end
end

10.times do
  crimes = Crime.all
  prisoner = Prisoner.create!(
    name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    check_in_date: Faker::Date.between(1.year.ago, Date.yesterday),
    check_out_date: Faker::Date.between(Date.tomorrow, 1.year.from_now)
  )
  prisoners << prisoner
  sentence = Sentence.create!(
    prisoner: prisoner,
    date_of_judgment: Faker::Date.between(1.month.from_now, 1.year.from_now),
    sentence_length: Faker::Number.between(30, 20000),
    threat: THREAT_TYPES.shuffle.first
  )
  sentences << sentence
  crimes_in_sentences << CrimesInSentence.create!(
    crime_type: crimes.shuffle.first.crime_type,
    sentence: sentence,
    count: rand(1..3)
  )
  resource = Resource.create!(
    resource_type: RESOURCE_TYPES.shuffle.first,
    name: Faker::Beer.name
  )
  resources << resource
  ResourcesAssignedToPrisoner.create!(
    resource: resource,
    prisoner: prisoners.shuffle.first,
    assignee_date: Date.yesterday
  )
  cell = Cell.where('capacity > 0').first
  Quarter.create!(
    cell: cell,
    block: cell.block,
    check_in_date: Faker::Date.between(1.year.ago, Date.yesterday),
    check_out_date: Faker::Date.between(Date.tomorrow, 1.year.from_now),
    prisoner: prisoner
  )
  cell.update(capacity: cell.capacity - 1)

  Pass.create!(
    pass_type: PASS_TYPES.shuffle.first,
    release_date: Faker::Date.between(Date.today, 3.months.from_now),
    length: Faker::Number.between(1, 30),
    prisoner: prisoner
  )

  incident = Incident.create!(
    date: Faker::Date.between(1.year.ago, Date.yesterday),
    location: Faker::Address.community,
    description: Faker::Lorem.sentence
  )

  PrisonersInIncident.create!(
    incident: incident,
    prisoner: prisoner
  )

  worker = CustodyWorker.create!(
    name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    position: Faker::Job.title
  )

  WorkersWorkingInBlock.create!(
    custody_worker: worker,
    block: cell.block
  )
end


