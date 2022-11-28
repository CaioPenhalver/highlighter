# frozen_string_literal: true

class UserCsvSerializer
  include Highlighter::CSV::Serializer

  columns :id, :name, :email
end
