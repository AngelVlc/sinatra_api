encrypt_configs:
	tar cvf config/configs.tar config/app.yml config/database.yml
	travis encrypt-file config/configs.tar -o config/configs.tar.enc
	rm config/configs.tar

bundle_audit:
	bundle-audit update
	bundle-audit check

tests:
	bundle exec rspec

console:
	bundle exec ruby script/console

test_console:
	RACK_ENV=test exec ruby script/console

migrate_dev:
	bundle exec rake rake db:migrate

migrate_test:
	RACK_ENV=test bundle exec rake db:migrate

start:
	foreman start