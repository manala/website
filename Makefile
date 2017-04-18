.SILENT:
.PHONY: install build watch

# Hugo
HUGO_THEME = 2016

include  manala/make/Makefile
-include Makefile.local

################
# Environments #
################

# Development
%@development: HUGO_OPTIONS += --buildDrafts --buildFuture

# Staging
%@staging: HUGO_OPTIONS += --buildDrafts --buildFuture

#########
# Setup #
#########

setup@development: install build

###########
# Install #
###########

## Install
install: $(call proxy,install)

## Install - Development
install@development:
	# Theme
	$(MAKE_HUGO_THEME) install@development

## Install - Staging
install@staging:
	# Theme
	$(MAKE_HUGO_THEME) install@staging

## Install - Production
install@production:
	# Theme
	$(MAKE_HUGO_THEME) install@production

#########
# Build #
#########

## Build
build: $(call proxy,build)

## Build - Development
build@development:
	# Theme
	$(MAKE_HUGO_THEME) build@development
	$(call log,Hugo)
	rm -Rf public && $(HUGO)

## Build - Staging
build@staging:
	# Theme
	$(MAKE_HUGO_THEME) build@staging
	$(call log,Hugo)
	rm -Rf public && $(HUGO)

## Build - Production
build@production:
	# Theme
	$(MAKE_HUGO_THEME) build@production
	$(call log,Hugo)
	rm -Rf public && $(HUGO)

#########
# Watch #
#########

## Watch
watch: DOCKER_OPTIONS = --publish 1313:1313
watch: DOCKER_SHELL   = dumb-init sh
watch: $(call proxy,watch)

## Watch - Development
watch@development:
	# Theme
	$(MAKE_HUGO_THEME) watch@development & \
	$(call log,Hugo - Server) && \
	$(HUGO_SERVER)

##########
# Deploy #
##########

deploy-staging: RSYNC_RSH = $(DEPLOY_RSH)
deploy-staging:
	$(RSYNC) public/ $(DEPLOY_DESTINATION)
