build_runner:
	flutter packages get && \
    flutter packages pub run build_runner build --delete-conflicting-outputs

clean:
	flutter pub run build_runner clean