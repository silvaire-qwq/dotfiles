#!/bin/zsh

local SNIPPET=(
    # [C] zinit snippet "string"
    # [P] string
    OMZ::plugins/git/git.plugin.zsh
    OMZ::lib/git.zsh
    OMZ::lib/clipboard.zsh
    OMZ::lib/completion.zsh
    OMZ::lib/history.zsh
    OMZ::lib/key-bindings.zsh
    OMZ::lib/theme-and-appearance.zsh
)

local LIGHT=(
    # [C] zinit light "string"
    # [P] string
    zdharma-continuum/history-search-multi-word
    Aloxaf/fzf-tab
    zsh-users/zsh-autosuggestions
    zdharma-continuum/fast-syntax-highlighting
    zsh-users/zsh-syntax-highlighting
    zsh-users/zsh-completions
    ael-code/zsh-colored-man-pages
)


# /---------- Set Opts  ----------/

local OPTIONS=(
    # 如果发出的命令无法作为正常命令执行，并且该命令是目录的名称，则执行对该目录的cd命令。此选项仅在设置了SHIN_STDIN选项时适用，即当从标准输入读取命令时。该选项专为交互式使用而设计；建议在脚本中明确使用cd以避免歧义。
    'AUTO_CD'
    # 使cd命令将旧目录推送到目录堆栈上。
    'AUTO_PUSHD'
    # 如果cd命令的参数（或设置了AUTO_CD选项时的隐含cd）不是一个目录，并且没有以斜杠开头，则尝试像在其前面加上‘~’一样展开表达式（参见文件名扩展）。
    'CDABLE_VARS'
    # 不要将同一目录的多个副本推送到目录堆栈上。
    'PUSHD_IGNORE_DUPS'
    # 如果在单词中的光标处执行补全，并插入了完整的补全内容，则光标将移动到单词的末尾。也就是说，如果插入了单个匹配项或执行了菜单补全，光标将移动到单词的末尾。
    'ALWAYS_TO_END'
    # 在模糊的补全时自动列出选择。
    'AUTO_LIST'
    # 在第二次连续请求补全后自动使用菜单补全，例如通过连续按制表键。这个选项被MENU_COMPLETE覆盖。
    'AUTO_MENU'
    # 如果参数名已完成并且自动插入了后续字符（通常是空格），并且接下来键入的字符是那些必须直接跟在名称后面的字符（如‘}’、‘:’等），则自动添加的字符将被删除，以便键入的字符紧跟在参数名称之后。在大括号扩展中的补全也有类似的影响：添加的字符是‘,’，如果接下来键入‘}’，则将其删除。
    'AUTO_PARAM_KEYS'
    # 如果补全的参数的内容是目录的名称，则在末尾添加一个斜杠而不是空格。
    'AUTO_PARAM_SLASH'
    # 如果补全结果的最后一个字符是斜杠，并且接下来键入的字符是单词分隔符、斜杠或结束命令的字符（如分号或和号），则删除该斜杠。
    'AUTO_REMOVE_SLASH'
    # 当尝试命令补全或拼写纠正时，首先确保整个命令路径被哈希。这会使第一次补全变慢，但避免了拼写错误的错误报告。
    'HASH_LIST_ALL'
    # 当AUTO_LIST或BASH_AUTO_LIST也设置时，此选项生效。如果在命令行上有明确的前缀可以插入，那么将直接插入该前缀而不显示补全列表；换句话说，只有在没有任何内容会被插入的情况下，才会进行自动列出行为。在BASH_AUTO_LIST的情况下，这意味着列表将被延迟到函数的第三次调用时显示。
    'LIST_AMBIGUOUS'
    # 如果用于文件名生成的通配符模式格式不正确，则打印一条错误消息。（如果此选项未设置，则模式将保持不变。）
    'NO_BAD_PATTERN'
    # 将‘#’、‘~’和‘^’字符视为文件名生成等模式的组成部分。（未引用的初始‘~’始终会产生命名目录扩展。）
    'EXTENDED_GLOB'
    # 在替换参数时，将未设置参数视为空参数；在算术扩展和算术命令中读取参数值时，将未设置参数视为零参数。否则将作为错误处理。
    'UNSET'
    # 如果设置了此选项，zsh 会话会将历史列表追加到历史文件中，而不是替换它。因此，多个并行的 zsh 会话都会将其历史列表中的新条目添加到历史文件中，按照它们退出的顺序。当行数增长超过 $SAVEHIST 指定的值 20% 时，文件仍然会被定期重写以修剪它（也参见 HIST_SAVE_BY_COPY 选项）。
    'APPEND_HISTORY'
    # 将每个命令的开始时间戳（自纪元以来的秒数）和持续时间（以秒为单位）保存到历史文件中。这种前缀数据的格式是：': <开始时间>:<经过秒数>;<命令>'
    'EXTENDED_HISTORY'
    # 如果内部历史需要被修剪以添加当前命令行，设置此选项将首先导致最老的有重复的历史事件丢失，而不是丢失列表中的独特事件。您应该确保 HISTSIZE 的值大于 SAVEHIST 的值，以便为重复事件提供一些空间，否则一旦历史填充了独特事件，此选项的行为将与 HIST_IGNORE_ALL_DUPS 类似。
    'HIST_EXPIRE_DUPS_FIRST'
    # 在写入历史文件时，zsh 默认使用特设的文件锁定来避免某些操作系统上的已知锁定问题。使用此选项时，如果系统支持 fcntl 调用，则通过该方法进行锁定。在最新的操作系统上，这可能会提供更好的性能，特别是当文件存储在 NFS 上时可以避免历史记录损坏。
    'HIST_FCNTL_LOCK'
    # 在行编辑器中搜索历史记录条目时，即使重复项不连续，也不要显示之前找到的行的重复项。
    'HIST_FIND_NO_DUPS'
    # 当行上的第一个字符是空格，或者展开的别名之一包含前导空格时，从历史列表中删除命令行。只有正常的别名（不是全局别名或后缀别名）才有这种行为。请注意，该命令在内部历史记录中会一直存在，直到输入下一个命令之前才会消失，这允许您短暂地重新使用或编辑该行。如果您想在不输入另一个命令的情况下立即使其消失，请键入一个空格并按回车键。
    'HIST_IGNORE_SPACE'
    # 从历史列表中删除函数定义。请注意，函数在内部历史记录中会一直存在，直到输入下一个命令之前才会消失，这允许您短暂地重新使用或编辑该定义。
    'HIST_NO_FUNCTIONS'
    # 从添加到历史列表的每个命令行中删除多余的空白字符。
    'HIST_REDUCE_BLANKS'
    # 此选项是INC_APPEND_HISTORY的一个变体，其中在可能的情况下，历史条目在命令完成后写入文件，以便在EXTENDED_HISTORY格式的历史文件中正确记录命令所花费的时间。这意味着该历史条目不会立即从使用相同历史文件的其他shell实例中可用。此选项仅在关闭INC_APPEND_HISTORY和SHARE_HISTORY时才有用。这三个选项应视为互斥的。
    'INC_APPEND_HISTORY_TIME'
    # 尝试纠正命令的拼写。请注意，当HASH_LIST_ALL选项未设置或路径中的某些目录不可读时，首次使用某些命令时可能会错误地报告拼写错误。可以设置shell变量CORRECT_IGNORE为一个模式，以匹配永远不会作为更正建议提供的单词。
    'CORRECT'
    # 允许在交互式shell中使用注释。
    'INTERACTIVE_COMMENTS'
    # 在具有作业控制的 shell 退出之前，报告后台和挂起作业的状态；再次尝试退出 shell 将成功。NO_CHECK_JOBS 最好仅与 NO_HUP 结合使用，否则这些作业将自动被终止。如果从上一条命令行运行的命令中包含了 jobs 命令，则省略检查，因为假设用户知道存在后台或挂起作业。从函数部分“特殊函数”中定义的钩子函数之一中运行的 jobs 命令不计算在内。
    'CHECK_JOBS'
    # 在启用 CHECK_JOBS 时，同时检查正在运行和挂起的作业。当此选项被禁用时，zsh 仅检查挂起的作业，这与 bash 的默认行为相匹配。除非设置了 CHECK_JOBS，否则此选项没有效果。
    'CHECK_RUNNING_JOBS'
    # 当 shell 退出时，向正在运行的作业发送 HUP 信号。
    'HUP'
)

setopt $OPTIONS


# /---------- Command Not Found Handler ----------/

command_not_found_handler() {
}

# /---------- Custom Configs ----------/

# List (exa) Default Options
export EXA_DEFAULT_OPTS=(
    '--color=auto'
    '--icons=auto'
    '--binary' # 列出带二进制前缀的文件大小
    '--header' # 为每列添加标题行
    '--git' # 列出每个文件的 Git 状态(如果已跟踪或已忽略)
    '--sort=type'
    '-M'
    '--time-style=relative'
    '--smart-group'
)

# More Histories
export HISTSIZE=65535
export SAVEHIST=65535

# FZF Default Opts
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
--color=selected-bg:#45475a \
--height=100% --border --header-lines 1 --tac --tiebreak=begin \
--delimiter : \
--no-scrollbar --border-label "Search" \
"

# Source Profiles & Envs
. /etc/profile
. /etc/environment
. /etc/locale.conf

# Zoxide Init
eval "$(zoxide init zsh)"

# The Fxck Init
eval "$(thefuck --alias)"

# Starship Init
eval "$(starship init zsh)"

# Bun Init 
[ -s "/home/arch/.bun/_bun" ] && source "/home/arch/.bun/_bun"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# hide EOL sign ('%')
PROMPT_EOL_MARK=""

# /---------- Plugins Manager ----------/

autoload -Uz compinit
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
compinit -D

if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit"
	command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"

zinit ice lucid wait='0'
zinit ice lucid wait='0' atload='_zsh_autosuggest_start'

for zinit_temp ("${SNIPPET[@]}") {
    zinit snippet "$zinit_temp"
}
unset zinit_temp

for zinit_temp ("${LIGHT[@]}") {
    zinit light "$zinit_temp"
}
unset zinit_temp

# /---------- Aliases ----------/

alias 'banner'='sudo pacman -Rscn'
alias 'ban'='sudo pacman -R'
alias 'sync'='paru'
alias 'shotlist'='sudo timeshift --list'
alias 'snapshot'='sudo timeshift --create && sudo update-grub'
alias 'banshot'='sudo timeshift --delete && sudo update-grub'
alias 'clearshot'='sudo timeshift --delete-all && sudo update-grub'
alias 'backup'='sudo timeshift --delete-all && sudo timeshift --create && sudo update-grub'
alias 'weztermrc'='sudo nvim ~/.config/wezterm/wezterm.lua'
alias 'l'="exa -lha $EXA_DEFAULT_OPTS"
alias 'ls'="exa -lh $EXA_DEFAULT_OPTS"
alias 'la'="exa -lha $EXA_DEFAULT_OPTS"
alias 'll'="exa -lha $EXA_DEFAULT_OPTS"
alias 'lc'='lolcat'
alias 'nf'='neofetch'
alias '.zshrc'='nvim ~/.zshrc'
alias "cd"="z"
alias 'time'='sudo mkdir $(date -d today +%Y%m%d-%H%M%S)'
alias 'hypr'='cd ~/.config/hypr/source'
alias 'fox'='musicfox'
alias 'clean'='ccache -C && sudo rm -rf ~/.cache/yay && sudo rm -rf ~/.cache/paru && sudo rm -rf ~/.local/share/pikaur && sudo pacman -Sc && echo "OK!"'
alias 'prt'='figlet'
alias 'fw'="fzf --disabled --bind 'change:reload:rg {q}'"
alias 'ff'="find . | fzf"
alias 'c'='cava'
alias 'sd'='shutdown 0'
alias ...=../..
alias ....=../../..
alias .....=../../../..
alias ......=../../../../..
alias 1='cd -'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'
