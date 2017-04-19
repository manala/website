.SILENT:
.PHONY: install build watch

##########
# Manala #
##########

# Hugo
HUGO_THEME = 2017

# Optimize
OPTIMIZE_IMAGES = public

include manala/make/Makefile

#########
# Setup #
#########

setup@development: install

###########
# Install #
###########

## Install
install: $(call proxy,install)

## Install - All
install@%:
	# Theme
	$(MAKE_HUGO_THEME) install@$*

#########
# Build #
#########

## Build
build: $(call proxy,build)

## Build - All
build@%:
	# Theme
	$(MAKE_HUGO_THEME) build@$*

	$(call log,Hugo)
	$(HUGO)

#########
# Watch #
#########

## Watch
watch: $(call proxy,watch)

## Watch - Development
watch@development: SHELL = dumb-init sh
watch@development:
	# Theme
	$(MAKE_HUGO_THEME) watch@development & \
	$(call log,Hugo - Server) && \
	$(HUGO_SERVER)

##########
# Deploy #
##########

## Deploy - Staging
deploy.staging: RSYNC_RSH = $(DEPLOY_RSYNC_RSH)
deploy.staging:
	$(call log,Rsync)
	$(RSYNC) public/ $(DEPLOY_DESTINATION)$(if $(DEPLOY_DESTINATION_SUFFIX),/$(DEPLOY_DESTINATION_SUFFIX))
