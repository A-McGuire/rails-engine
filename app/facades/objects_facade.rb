class ObjectsFacade
  class << self
    def all_objects_helper(model, params)
      return model.all_objects() if params[:page].nil? && params[:per_page].nil?
      return model.all_objects(params[:page].to_i, params[:per_page].to_i) if params[:page].present? && params[:per_page].present?
      return model.all_objects(1, params[:per_page].to_i) if params[:per_page].present?
      return model.all_objects(params[:page].to_i) if params[:page].present?
    end
  end
end