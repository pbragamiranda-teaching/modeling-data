require_relative "patient"
require "csv"

class PatientRepository
  def initialize(csv_file_path, room_repository)
    @patients = []
    @csv_file_path = csv_file_path
    @room_repository = room_repository
    @next_id = 1 # autoincrement strategy
    load_csv
  end

  def add(patient)
    patient.id = @next_id
    @next_id += 1
    @patients << patient
    # save_csv
  end

  def load_csv
    CSV.foreach(@csv_file_path, headers: :first_row, header_converters: :symbol) do |row|
      row[:id]    = row[:id].to_i          # Convert column to Integer
      row[:cured] = row[:cured] == "true"  # Convert column to boolean
      # Look in which Room the patient is located
      room = @room_repository.find(row[:room_id])
      # Assing the room to the patient
      patient = Patient.new(row)
      patient.room = room
      @patients << patient
    end
    @next_id = @patients.empty? ? 1 : @patients.last.id + 1
  end
end

repo = PatientRepository.new("patients.csv")

maria = Patient.new(cured: true, name: "Maria", blood_type: "A")
repo.add(maria)

p repo
