module ApplicationHelper
  def i18n_model_values(att_to_translate, instance_model)
    value_to_translate = instance_model.read_attribute att_to_translate
    value_to_translate = value_to_translate.to_s.underscore.split().join("_") if value_to_translate.present?
    model_to_translate = instance_model.class.to_s.try(:underscore)
    scope_to_translate = "model.#{model_to_translate}"
    I18n.t(value_to_translate, scope: scope_to_translate, default: instance_model.read_attribute(att_to_translate))
  end

end
