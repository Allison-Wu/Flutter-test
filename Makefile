generate_coverage_html:
	flutter test --coverage
	genhtml -o coverage-result coverage/lcov.info

publish_coverage: generate_coverage_html
	bash -c "bash <(curl -s https://codecov.io/bash) -t $(CODECOV_TOKEN)"
