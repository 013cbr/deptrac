PHP_BIN      := php
COMPOSER_BIN := composer
BOX_BIN      := box
SHA1SUM		 := sha1sum

.PHONY: build composer-install-dev tests tests-coverage

build: tests
	$(COMPOSER_BIN) install --no-dev --optimize-autoloader
	$(BOX_BIN) build
	chmod +x deptrac.phar
	$(SHA1SUM) deptrac.phar > deptrac.version

composer-install-dev:
	$(COMPOSER_BIN) install --optimize-autoloader

tests: composer-install-dev
	$(PHP_BIN) ./vendor/phpunit/phpunit/phpunit -c .

tests-coverage: composer-install-dev
	$(PHP_BIN) ./vendor/phpunit/phpunit/phpunit -c . --coverage-html coverage


test-integration-sylius:
	#git clone git@github.com:Sylius/Sylius.git /tmp/c1023228a
	php deptrac.php analyze examples/symfony_depfile.yml