class BaseService
  attr_reader :errors

  def add_error(error = nil)
    @error = error.is_a?(Array) ? error : [error]
  end

  def success?
    !@errors
  end
  
end