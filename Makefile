all:
	echo "Try being more specific."


# Configure `nvim`
NVIM_FOLDER=~/.config/nvim
NVIM_INIT_SRC=nvim/init.vim
NVIM_INIT_DST=$(NVIM_FOLDER)/init.vim
$(NVIM_INIT_DST):
	mkdir -p $(NVIM_FOLDER)
	ln $(NVIM_INIT_SRC) $(NVIM_INIT_DST)

VIM_PLUG_SRC_URL=https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
VIM_PLUG_DST=$(NVIM_FOLDER)/autoload/plug.vim
$(VIM_PLUG_DST):
	curl -fLo $(VIM_PLUG_DST) --create-dirs $(VIM_PLUG_SRC_URL)
nvim: $(NVIM_INIT_DST) $(VIM_PLUG_DST)
	nvim -c ":PlugInstall"
