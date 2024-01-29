class ActivitySerializer
  include JSONAPI::Serializer
  attributes :id, :title, :overview, :body, :image, :manpower_needed, :location, :time_start, :time_end,
  :created_at, :updated_at
end
