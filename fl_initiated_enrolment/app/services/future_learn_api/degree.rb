module FutureLearnApi
  class Degree
    include Connection

    def get(uuid)
      response = connection.get(
        'degrees/' + uuid
      )

      parse_json_response(response)
    end
  end
end
