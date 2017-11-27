module FutureLearnApi
  class Learner
    include Connection

    def get(uuid)
      response = connection.get(
        'learners/' + uuid
      )

      parse_json_response(response)
    end
  end
end
