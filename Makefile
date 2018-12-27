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
