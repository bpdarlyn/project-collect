class Api::V1::PeopleController < Api::V1::ApplicationController
  def search
    query = params[:query]
    return render json: {type: RESPONSE_SUCCESSFULLY, payload: []} unless query.present?
    people = Person.custom_fields(query)
    render json: {
        type: RESPONSE_SUCCESSFULLY,
        payload: ActiveModel::Serializer::CollectionSerializer.new(people, serializer: PersonSerializer)
    }
  end
end
