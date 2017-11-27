module FutureLearnApi
  class OrganisationMembership
    include Connection

    def post(params)
      response = connection.post(
        'organisation_memberships',
        params
      )

      parse_json_response(response)
    end

    def find(external_learner_id)
      response = connection.get(
        'organisation_memberships/find',
        external_learner_id: external_learner_id
      )

      parse_json_response(response)
    end
  end
end
