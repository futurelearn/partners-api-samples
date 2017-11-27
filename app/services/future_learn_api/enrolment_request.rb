module FutureLearnApi
  class EnrolmentRequest
    include Connection

    def get(uuid)
      response = connection.get(
        'enrolment_requests/' + uuid
      )

      parse_json_response(response)
    end

    def post(params)
      response = connection.post(
        'enrolment_requests',
        params
      )

      parse_json_response(response)
    end

    def patch(uuid, params)
      response = connection.patch(
        'enrolment_requests/' + uuid,
        params
      )

      parse_json_response(response)
    end

    def token_exchange(token)
      response = connection.post(
        'enrolment_requests/token_exchange',
        token: token
      )

      parse_json_response(response)
    end
  end
end
