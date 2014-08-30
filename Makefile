
all:
	# Hoverbear's Arch Linux friendly dotfile config.
	# Choose a task:
	#  * nvim - Install nvim & configs

# General settings
PACKAGE_MANAGER_INSTALL=sudo pacman -Sy

# Configure `nvim`
NVIM_CONFIG_FOLDER=~/.config/nvim
NVIM_INIT_SRC=nvim/init.vim
NVIM_INIT_DST=$(NVIM_CONFIG_FOLDER)/init.vim
NVIM_PLUG_SRC_URL=https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
NVIM_PLUG_DST=$(NVIM_CONFIG_FOLDER)/autoload/plug.vim

nvim: $(NVIM_INIT_DST) $(NVIM_PLUG_DST)
# Install the `~/.config/nvim/init.vim` file.
$(NVIM_INIT_DST):
	mkdir -p $(NVIM_CONFIG_FOLDER)
	ln $(NVIM_INIT_SRC) $(NVIM_INIT_DST)
# Now we install `vim-plugged` and trigger a `:PlugInstall`
$(NVIM_PLUG_DST):
	curl -fLo $(NVIM_PLUG_DST) --create-dirs $(NVIM_PLUG_SRC_URL)
	nvim -c ":PlugInstall"


