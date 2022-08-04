# Makefile

ORGNAME="55DB091A-8471-447B-8F50-5DFF4C1B14AC"
REPO_URL="git@github.com:$(ORGNAME)/Lighter.git"
BASEPATH="Documentation/"
LOCAL_REPO_PATH="$(PWD)"
CHECKOUT_PATH="$(LOCAL_REPO_PATH)/checkout"
OUTPUT_PATH="$(LOCAL_REPO_PATH)/docs"

# TODO: Need to merge the outputs
all : sqlite3schema-docs lighter-docs

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
