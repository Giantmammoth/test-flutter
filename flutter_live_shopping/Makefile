build_runner:
	@echo "Running build_runner..."
	dart run build_runner build --delete-conflicting-outputs

build_runner_watch:
	@echo "Running build_runner in watch mode..."
	dart run build_runner watch --delete-conflicting-outputs

build_runner_clean:
	@echo "Cleaning build_runner outputs..."
	dart run build_runner clean

gen_l10n:
	@echo "Generating localizations..."
	flutter gen-l10n

analyze_all:
	@echo "Running analysis on all packages and apps..."
	dart analyze --fatal-infos --fatal-warnings . && \
	dart format --set-exit-if-changed .  && \
	dcm analyze . --ci-key=${DCM_CI_KEY} --email=${DCM_EMAIL} --fatal-style && \
	dcm check-unused-files . --ci-key=${DCM_CI_KEY} --email=${DCM_EMAIL} --exclude="**/*.internal.dart" --exclude-public-api && \
	dcm check-unused-l10n . --ci-key=${DCM_CI_KEY} --email=${DCM_EMAIL} --class-pattern=^AppLocalizations$ && \
	dcm check-unused-code . --ci-key=${DCM_CI_KEY} --email=${DCM_EMAIL} --exclude="{**/*.internal.dart,**/app_localizations.dart}" --exclude-public-api && \
	dcm analyze-assets . --ci-key=${DCM_CI_KEY} --email=${DCM_EMAIL} --naming=snake --allowed-formats=icons:svg,images:png --no-resolution --exclude="assets/onboarding/*" && \
	dcm check-dependencies . --ci-key=${DCM_CI_KEY} --email=${DCM_EMAIL} --ignored-packages="flutter_gen" && \
	dcm check-code-duplication . --ci-key=${DCM_CI_KEY} --email=${DCM_EMAIL}

gen_assets:
	@echo "Generating images..."
	fgen

base64_encode_env_production:
	@echo "Encoding production environment variables..."
	cat .env.prod | base64 | pbcopy

base64_encode_env_staging:
	@echo "Encoding staging environment variables..."
	cat .env.stg | base64 | pbcopy

base64_encode_env_staging_fastlane_android:
	@echo "Encoding staging environment variables..."
	cd android/fastlane && cat .env.stg | base64 | pbcopy

base64_encode_service_credentials_staging_fastlane_android:
	@echo "Encoding staging environment variables..."
	cd android/fastlane && cat service_credentials.json | base64 | pbcopy

base64_encode_env_production_fastlane_android:
	@echo "Encoding production environment variables..."
	cd android/fastlane && cat .env.prod | base64 | pbcopy

gz:
	@echo "Writing conventional commit comments..."
	npx czg emoji

build_android_staging:
	@echo "Building Android app for staging..."
	cd android && bundle exec fastlane build_android --env stg

deploy_android_staging:
	@echo "Deploying Android app to staging..."
	cd android && bundle exec fastlane deploy_android --env stg

build_ios_staging:
	@echo "Building ios app for staging..."
	cd ios && bundle exec fastlane build_ios --env stg

deploy_ios_staging:
	@echo "Deploying ios app to staging..."
	cd ios && bundle exec fastlane deploy_ios --env stg