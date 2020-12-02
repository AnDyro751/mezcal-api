Paperclip::Attachment.default_options.merge!(
    storage: :fog,
    fog_credentials: {
        provider: 'AWS',
        aws_access_key_id: "AKIAYAOMZIQZPJCWNBJJ",
        aws_secret_access_key: "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",
        region: "us-east-1",
    },
    fog_directory: "waydda-qr",
)

Spree::Image.attachment_definitions[:attachment].delete(:url)
Spree::Image.attachment_definitions[:attachment].delete(:path)


# Spree.config do |config|
#     attachment_config = {
#         s3_credentials: {
#             access_key_id:"AKIAYAOMZIQZPJCWNBJJ",
#             secret_access_key: "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",
#             bucket: "waydda-qr"
#         },
#
#         storage:        :s3,
#         s3_headers:     { "Cache-Control" => "max-age=31557600" },
#         s3_region:      "us-east-1",
#         bucket:         "waydda-qr",
#         path:          "/:class/:id/:style/:basename.:extension",
#         default_url:   "noimage/:style.png",
#         default_style: "product"
#     }
#
#     attachment_config.each do |key, value|
#         Spree::Image.attachment_definitions[:attachment][key.to_sym] = value
#     end
# end unless Rails.env.test?