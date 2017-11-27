module FutureLearnApi
  class ProgramRun
    include Connection

    def get(uuid)
      response = connection.get('program_runs/' + uuid)

      parse_json_response(response)
    end

    def find(program_code, program_run_code)
      response = connection.get(
        'program_runs/find',
        program_code: program_code,
        program_run_code: program_run_code
      )

      parse_json_response(response)
    end
  end
end
