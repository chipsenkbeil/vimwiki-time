NVIM = nvim -N -u NORC -i NONE --cmd 'set rtp+=test/deps/vim-vader rtp+=test/deps/vimwiki rtp+=$$PWD'

help: ## Display help information
	@printf 'usage: make [target] ...\n\ntargets:\n'
	@egrep '^(.+)\:\ .*##\ (.+)' ${MAKEFILE_LIST} | sed 's/:.*##/#/' | column -t -c 2 -s '#'

test: test/deps ## Runs tests for neovim
	VADER_OUTPUT_FILE=/dev/stderr $(NVIM) --headless '+Vader! test/*.vader'

testi: test/deps ## Runs tests interactively for neovim
	$(NVIM) '+Vader test/*.vader'

test/deps: test/deps/vimwiki test/deps/vim-vader

test/deps/vimwiki:
	git clone https://github.com/vimwiki/vimwiki test/deps/vimwiki || ( cd test/deps/vimwiki && git pull --rebase && git checkout dev; )

test/deps/vim-vader:
	git clone https://github.com/junegunn/vader.vim test/deps/vim-vader || ( cd test/deps/vim-vader && git pull --rebase; )

.PHONY: help test testi
