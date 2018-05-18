ThinkingSphinx::Index.define :user, with: :real_time do
  indexes name,     sortable: true
  indexes username, sortable: true
  indexes email

  has conversation_ids, type: :integer, multi: :true
  has created_at,       type: :timestamp
  has updated_at,       type: :timestamp
end