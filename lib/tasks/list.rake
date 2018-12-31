namespace :list do
  desc 'fetch user lists'
  task fetch: :environment do
    User.all.each do |user|
      user.fetch_lists
    end
  end
end
