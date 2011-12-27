class Memory < Repo
    attr_accessible :name, :owner_id, :expires_on, :source_language_id, :url, :target_language_id, :content, :token
end