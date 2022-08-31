module MissionControl::Web::MemoizeWithTtl
  def memoize_with_ttl(name, ttl_seconds = MissionControl::Web.configuration.cache_ttl)
    value_ivar, expiry_ivar = :"@#{name}", :"@#{name}_expires_at"
    memoized_value, expiry  = instance_variable_get(value_ivar), instance_variable_get(expiry_ivar)

    if !memoized_value.nil? && expiry > Time.now
      memoized_value
    else
      instance_variable_set(value_ivar, result = yield)
      instance_variable_set(expiry_ivar, Time.now + ttl_seconds)
      result
    end
  end
end
