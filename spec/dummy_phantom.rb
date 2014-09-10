class DummyPhantom
  attr_accessor(
    :phantom_file_name,
    :phantom_file_size,
    :phantom_updated_at,
    :phantom_content_type,
    :phantom_fingerprint,
    :id
  )

  def errors
    @errors ||= []
  end

  def run_paperclip_callbacks name, *args
  end

  def valid?
    errors.empty?
  end
end
