#require_relative 'paperclip'
Cms::CompressionConfig.initialize_compression(html_compress: false)
if !ENV["STD_PRECOMPILE"]
  Cms::AssetsPrecompile.initialize_precompile
end

Cms.config.provided_locales do
  [:uk, :en]
end

Cms.config.use_translations true

Cms.config.sitemap_controller({entries_for_resources: {locales: [:uk, :en] } })

