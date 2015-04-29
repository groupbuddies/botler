namespace :periodic_expenses do
  task :run => :environment do
    PeriodicExpenseRunner.new.run
  end
end
