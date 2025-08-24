brewfile := Brewfile
brew_check_bundle := bundle check --file $(brewfile)
brew_install_bundle := bundle install --file $(brewfile)
generator_dir := generators
generators := $(wildcard $(generator_dir)/*.jsonnet)
target_dir := assets/complex_modifications
targets := $(patsubst $(generator_dir)/%.jsonnet, %.json, $(generators))
config := $(HOME)/.config/karabiner

.PHONY: all init check install generate

all: generate

init: check generate
ifeq ($(PWD), $(config))
else
	command mv $(config) $(config)_backup
	command ln -s $(PWD) $(config)
	command launchctl kickstart -k gui/`id -u`/org.pqrs.karabiner.karabiner_console_user_server
endif

check: install
	@brew $(brew_check_bundle)

install:
	@brew $(brew_check_bundle) 1>/dev/null || (\
		echo 'Installing missing dependencies...';\
		brew $(brew_install_bundle);\
	)

generate: $(targets)
	@echo All targets are up-to-date

$(targets): %.json: %.jsonnet

%.jsonnet:
	$(eval target := $(target_dir)/$(@:.jsonnet=.json))
	$(eval generator := $(generator_dir)/$@)

	@if [ $(generator) -nt $(target) ]; then\
		rm -rf $(target);\
		echo Generating target for $@;\
		jsonnet $(generator) -o $(target);\
		karabiner_cli --lint-complex-modifications $(target);\
	fi

