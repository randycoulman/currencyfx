require "vcr"

VCR.configure do |c|
  c.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  c.hook_into :webmock
  c.configure_rspec_metadata!
  c.filter_sensitive_data('<API_KEY>') { ENV["OPEN_EXCHANGE_RATES_API_KEY"] }
end
