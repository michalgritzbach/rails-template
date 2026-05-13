# frozen_string_literal: true

SimpleForm.setup do |config|
  config.wrappers :default, class: "flex flex-col gap-1 mb-4",
    hint_class: "text-xs text-pg-text2 mt-0.5",
    error_class: "field_with_errors",
    valid_class: nil do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :minlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly
    b.use :label, class: "text-sm font-bold text-pg-text2"
    b.use :input,
      class: "w-full rounded-lg border border-pg-border bg-pg-surface px-3 py-2 text-sm text-pg-text placeholder-pg-text2 focus:outline-none focus:ring-2 focus:ring-pg-accent focus:border-transparent transition",
      error_class: "border-red-400 focus:ring-red-400"
    b.use :hint,  wrap_with: { tag: :span, class: "text-xs text-pg-text2" }
    b.use :error, wrap_with: { tag: :span, class: "text-xs text-red-500 font-medium" }
  end

  config.wrappers :check_box, class: "flex items-center gap-2 mb-4" do |b|
    b.use :html5
    b.use :input,  class: "rounded border-pg-border text-pg-accent focus:ring-pg-accent"
    b.use :label,  class: "text-sm font-medium text-pg-text"
    b.use :hint,   wrap_with: { tag: :span, class: "text-xs text-pg-text2" }
    b.use :error,  wrap_with: { tag: :span, class: "text-xs text-red-500 font-medium" }
  end

  config.wrappers :meal_picker, class: "flex flex-col gap-2 mb-4" do |b|
    b.use :label, class: "text-sm font-bold text-pg-text2"
    b.use :input
    b.use :error, wrap_with: { tag: :span, class: "text-xs text-red-500 font-medium" }
  end

  config.wrappers :species_picker, class: "flex flex-col gap-2 mb-4" do |b|
    b.use :label, class: "text-sm font-bold text-pg-text2"
    b.use :input, collection_wrapper_tag: :div, collection_wrapper_class: "pg-species-picker",
          item_wrapper_tag: false
    b.use :error, wrap_with: { tag: :span, class: "text-xs text-red-500 font-medium" }
  end

  config.default_wrapper        = :default
  config.boolean_style          = :nested
  config.button_class           = "pg-btn pg-btn--md pg-btn--primary"
  config.error_notification_tag = :div
  config.error_notification_class = "pg-card border-red-400 bg-red-50 text-red-700 text-sm mb-4"
  config.browser_validations    = false
  config.boolean_label_class    = "checkbox"

  config.wrapper_mappings = { boolean: :check_box }
end
