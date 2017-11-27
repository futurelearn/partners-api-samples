class EnrolmentRequest < ApplicationRecord
  Learner = Struct.new(:first_name, :last_name, :email)
  Degree = Struct.new(:title, :code)
  ProgramRun = Struct.new(:title, :code)

  def degree
    @degree ||=  begin
      degree_hash = FutureLearnApi::Degree.new.get(degree_uuid)

      Degree.new(degree_hash['title'], degree_hash['code'])
    end
  end

  def program_run
    @program_run ||=  begin
      program_run_hash = FutureLearnApi::ProgramRun.new.get(program_run_uuid)
      program_hash =  FutureLearnApi::Program.new.get(program_run_hash['program']['uuid'])

      ProgramRun.new(program_hash['title'], program_run_hash['code'])
    end
  end

  def learner
    @learner ||= begin
      learner_hash = FutureLearnApi::Learner.new.get(learner_uuid)

      Learner.new(learner_hash['first_name'], learner_hash['last_name'], learner_hash['email'])
    end
  end
end
