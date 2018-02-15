module FutureLearnApi
  class Program
    include Connection

    def get(uuid)
      response = connection.get('programs/' + uuid)

      parse_json_response(response)
    end
  end
end
