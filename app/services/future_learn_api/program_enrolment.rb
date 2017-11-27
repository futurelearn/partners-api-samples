module FutureLearnApi
  class ProgramEnrolment
    include Connection

    def post(params)
      response = connection.post(
        'program_enrolments',
        params
      )

      parse_json_response(response)
    end
  end
end
