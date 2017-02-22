namespace :squortz do
  # task for delete previous data
  task remove_previous_data: :environment do
    begin
      conditions = "(created_at < '#{Date.today - 1}' and duration = 'daily') or
        (created_at < '#{Date.today.prev_week}' and duration = 'weekly') or
        (extract(month from created_at) = '#{Date.today.prev_month.month - 1}' and duration = 'monthly') or
        (extract(year from created_at) = '#{Date.today.prev_year.year - 1}' and duration = 'yearly')"

      Horoscope.where(conditions).delete_all
      puts 'Remove Previous Daily Horoscope Data'
    rescue => e
      puts "Error for Horoscope -- #{e}"
    end
  end
end