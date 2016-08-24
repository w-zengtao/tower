class EventSerializer < ActiveModel::Serializer
  attributes :id, :act, :user_id, :eventable

  belongs_to :eventable_type do
    object.eventable.class.to_s
  end
  belongs_to :eventable_id do
    object.eventable.id
  end
end
