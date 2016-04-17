all:
	# Hoverbear's friendly dotfile config.
	# Choose a task:
	#  * nvim - Install nvim configs
	#  * zsh  - Install zsh configs
	#  * tmux - Install tmux configs
	#  * i3   - Install i3 configs
	#  * i3lock - Install i3 auto lock task.
CONFIG_FOLDER=~/.config

# Used for some potential cross-device links since we have to copy there.
.FORCE:
	# Since we copy we ~always~ do this task even if it's up to date.

#
# Configure `nvim`
#
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

#
# Configure `zsh`
#
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
# Configure the prompt.
$(ZSH_PROMPT_DST):
	mkdir -p $(ZSH_CONFIG_FOLDER)
	ln $(ZSH_PROMPT_SRC) $(ZSH_PROMPT_DST)

#
# Configure `tmux`
#
TMUX_CONFIG_FOLDER=$(CONFIG_FOLDER)/tmux
TMUX_CONF_SRC=tmux/tmux.conf
TMUX_CONF_DST=~/.tmux.conf
TMUX_PROMPT_SRC=tmux/prompt.conf
TMUX_PROMPT_DST=$(TMUX_CONFIG_FOLDER)/prompt.conf

tmux: $(TMUX_CONF_DST) $(TMUX_PROMPT_DST)
# Install the tmux config.
$(TMUX_CONF_DST):
	ln $(TMUX_CONF_SRC) $(TMUX_CONF_DST)
# Now install the prompt into the expected place.
$(TMUX_PROMPT_DST):
	mkdir -p $(TMUX_CONFIG_FOLDER)
	ln $(TMUX_PROMPT_SRC) $(TMUX_PROMPT_DST)

#
# Configure the powerline fonts for airline.
# Used in nvim/tmux/zsh
#
POWERLINE_SYMBOLS_URL=https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
POWERLINE_CONF_URL=https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf
FONT_FOLDER=~/.fonts/
POWERLINE_SYMBOLS_DST=$(FONT_FOLDER)/PowerlineSymbols.otf
FONTCONFIG_FOLDER=$(CONFIG_FOLDER)/fontconfig/conf.d/
POWERLINE_CONF_DST=$(FONTCONFIG_FOLDER)/10-powerline-symbols.conf

fonts: $(POWERLINE_SYMBOLS_DST) $(POWERLINE_CONF_DST)
$(POWERLINE_SYMBOLS_DST):
	mkdir -p $(FONT_FOLDER)
	curl -fL $(POWERLINE_SYMBOLS_URL) -o $(POWERLINE_SYMBOLS_DST)
	fc-cache -vf $(FONT_FOLDER)
$(POWERLINE_CONF_DST):
	mkdir -p $(FONTCONFIG_FOLDER)
	curl -fL $(POWERLINE_CONF_URL) -o $(POWERLINE_CONF_DST)

#
# Configure any touchpads with some sane, modern settings.
#
SYNAPTICS_SRC=trackpad/60-synaptics.conf
XORG_CONF=/etc/X11/xorg.conf.d/
SYNAPTICS_DST=$(XORG_CONF)/60-synaptics.conf

trackpad: $(SYNAPTICS_DST)
$(SYNAPTICS_DST): .FORCE
	sudo mkdir -p $(XORG_CONF)
	sudo cp $(SYNAPTICS_SRC) $(SYNAPTICS_DST)


#
# Configure i3
#
I3_CONFIG_FOLDER=$(CONFIG_FOLDER)/i3
I3STATUS_CONFIG_FOLDER=$(CONFIG_FOLDER)/i3status
I3_CONFIG_SRC=i3/config
I3_CONFIG_DST=$(I3_CONFIG_FOLDER)/config
I3STATUS_CONFIG_SRC=i3/status-config
I3STATUS_CONFIG_DST=$(I3STATUS_CONFIG_FOLDER)/config

i3: $(I3_CONFIG_DST) $(I3STATUS_CONFIG_DST)
# Install the i3 config.
$(I3_CONFIG_DST):
	mkdir -p $(I3_CONFIG_FOLDER)
	ln $(I3_CONFIG_SRC) $(I3_CONFIG_DST)
$(I3STATUS_CONFIG_DST):
	mkdir -p $(I3STATUS_CONFIG_FOLDER)
	ln $(I3STATUS_CONFIG_SRC) $(I3STATUS_CONFIG_DST)

# Running this task will make `i3lock` spawn before each suspend.
I3LOCK_SERVICE=i3lock.service
I3LOCK_SRC=i3/$(I3LOCK_SERVICE)
I3LOCK_DST=$(CONFIG_FOLDER)/systemd/user/$(I3LOCK_SERVICE)
i3lock: $(I3LOCK_DST)
$(I3LOCK_DST): .FORCE
	mkdir -p $(CONFIG_FOLDER)/systemd/user/
	# Must copy, unfortunately! Many people put /etc on a different partition.
	ln $(I3LOCK_SRC) $(I3LOCK_DST)
	systemctl --user enable $(I3LOCK_SERVICE)
