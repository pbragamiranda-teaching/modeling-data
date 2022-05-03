require_relative 'patient'

class Room
  attr_accessor :id
  # STATE
  # capacity (Intenger)
  # patients (an array of Patient instances)

  def initialize(attributes = {})
    @capacity = attributes[:capacity] || 0
    @patients = attributes[:patients] || []
  end

  # BEHAVIOR
  # add_patient
  # full?
  def full?
    @capacity == @patients.size
  end

  def add_patient(patient)
    if full?
      raise StandardError, "The room is full"
    else
      patient.room = self
      @patients << patient
    end
  end
end

# room_1 = Room.new(capacity: 2)

# george = Patient.new(name: "George", cured: false)
# room_1.add_patient(george)

# maria = Patient.new(cured: true, name: "Maria", blood_type: "A")
# room_1.add_patient(maria)

# george = Patient.new(name: "George", cured: false)
# room_1.add_patient(george)

# maria = Patient.new(cured: true, name: "Maria", blood_type: "A")
# room_1.add_patient(maria)


# begin
#   alex = Patient.new(name: "Alex")
#   room_1.add_patient(alex)
# rescue
#   puts "The room was full. continuing.."
# end

# puts "Testing if code will be executed"
