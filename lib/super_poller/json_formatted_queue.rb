require 'delegate'
require 'json'

class SuperPoller::JsonFormattedQueue < DelegateClass(SuperPoller::GenericQueue)
  def pop
    coerce_from_json(super)
  end

  def push(v)
    super(v.to_json)
  end

  def fetch
    coerce_from_json(super)
  end

protected
  def coerce_from_json(json)
    if json.is_a? String
      try_parse_json(json)
    else
      coerce_from_json(json.to_json)
    end
  end

  def try_parse_json(json)
    JSON.parse(json)
  rescue JSON::ParserError
    JSON.parse(json.to_json)
  end
end