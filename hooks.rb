# features/support/hooks.rb
Before do
  # Her senaryodan önce veritabanını tohumla (seed)
  Rails.application.load_seed
end