all:
	# Hoverbear's Arch Linux friendly dotfile config.
	# Choose a task:
	#  * nvim - Install nvim configs
	#  * zsh  - Install zsh configs

CONFIG_FOLDER=~/.config

# Configure `nvim`
NVIM_CONFIG_FOLDER=$(CONFIG_FOLDER)/nvim
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

# Configure `zsh`
ZSH_CONFIG_FOLDER=$(CONFIG_FOLDER)/zsh
ZSH_RC_SRC=zsh/zshrc
ZSH_RC_DST=~/.zshrc
ZSH_ANTIGEN_SRC_URL=https://raw.githubusercontent.com/zsh-users/antigen/master/antigen.zsh
ZSH_ANTIGEN_DST=$(ZSH_CONFIG_FOLDER)/antigen.zsh
ZSH_PROMPT_SRC=zsh/prompt.zsh
ZSH_PROMPT_DST=$(ZSH_CONFIG_FOLDER)/prompt.zsh

zsh: $(ZSH_RC_DST) $(ZSH_PROMPT_DST) $(ZSH_ANTIGEN_DST)
# Install the `~/.zshrc`
$(ZSH_RC_DST):
	ln $(ZSH_RC_SRC) $(ZSH_RC_DST)
# Now install `antigen`
$(ZSH_ANTIGEN_DST):
	curl -fLo  $(ZSH_ANTIGEN_DST) --create-dirs $(ZSH_ANTIGEN_SRC_URL)
$(ZSH_PROMPT_DST):
	mkdir -p $(ZSH_CONFIG_FOLDER)
	ln $(ZSH_PROMPT_SRC) $(ZSH_PROMPT_DST)

# Configure `tmux`
TMUX_CONFIG_FOLDER=$(CONFIG_FOLDER)/tmux
TMUX_CONF_SRC=tmux/tmux.conf
TMUX_CONF_DST=~/.tmux.conf
TMUX_PROMPT_SRC=tmux/prompt.conf
TMUX_PROMPT_DST=$(TMUX_CONFIG_FOLDER)/prompt.conf

tmux: $(TMUX_CONF_DST) $(TMUX_PROMPT_DST)
# Install the `~/.tmux.conf`
$(TMUX_CONF_DST):
	ln $(TMUX_CONF_SRC) $(TMUX_CONF_DST)
# Now install the prompt into `~/.config/tmux/prompt.zsh`
$(TMUX_PROMPT_DST):
	mkdir -p $(TMUX_CONFIG_FOLDER)
	ln $(TMUX_PROMPT_SRC) $(TMUX_PROMPT_DST)
