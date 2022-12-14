# Makefile

ORGNAME="lighter-swift"
REPO_URL="git@github.com:$(ORGNAME)/Lighter.git"
BASEPATH="/"
LOCAL_REPO_PATH="$(PWD)"
CHECKOUT_PATH="$(LOCAL_REPO_PATH)/checkout"
OUTPUT_PATH="$(LOCAL_REPO_PATH)/docs"

# TODO: Need to merge the outputs
all : lighter-docs
	cp docs-index.html docs/index.html

clean:
	rm -rf .build checkout docs Package.resolved

checkout-or-update:
	if test -d "$(CHECKOUT_PATH)"; then \
	  cd  "$(CHECKOUT_PATH)";\
	else \
	  mkdir "$(CHECKOUT_PATH)";\
	  cd "$(CHECKOUT_PATH)";\
	fi;\
	if test -d Lighter; then\
	  cd Lighter && git pull && cd ..;\
	else\
	  git clone "$(REPO_URL)";\
	fi;\
	rm Lighter/Package*.swift;\
	cp "$(LOCAL_REPO_PATH)/Package.swift" Lighter/

lighter-docs: checkout-or-update
	cd $(CHECKOUT_PATH)/Lighter; \
	swift package \
	  --allow-writing-to-directory "$(OUTPUT_PATH)" \
	  generate-documentation \
	  --target Lighter \
	  --disable-indexing \
	  --transform-for-static-hosting \
	  --hosting-base-path "$(BASEPATH)" \
	  --output-path "$(OUTPUT_PATH)"

sqlite3schema-docs: checkout-or-update
	cd $(CHECKOUT_PATH)/Lighter; \
	swift package \
	  --allow-writing-to-directory "$(OUTPUT_PATH)" \
	  generate-documentation \
	  --target SQLite3Schema \
	  --disable-indexing \
	  --transform-for-static-hosting \
	  --hosting-base-path "$(BASEPATH)" \
	  --output-path "$(OUTPUT_PATH)"
