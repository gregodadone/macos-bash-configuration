export BASH_SILENCE_DEPRECATION_WARNING=1
export PATH=/opt/homebrew/bin:$PATH
export JAVA_HOME=$(/usr/libexec/java_home)
[[ -r "/opt/homebrew/etc/bash_completion" ]] && . "/opt/homebrew/etc/bash_completion"

function set_prompt_arguments {
    local __git_user_email="$(git config user.email 2>/dev/null)"
    local __git_user_email_username="${__git_user_email%@*}"
    local __git_username="${__git_user_email_username:-unset}"
    local __user="\[\033[01;33m\]$__git_username"
    #local __user="\[\033[01;33m\]\u@"
    local __host="\[\e[1;32m\]\h"
    local __cur_location="\[\033[01;32m\]\w"
    local __git_branch_color="\[\033[31m\]"
    local __git_branch='`git branch 2> /dev/null | grep -e ^* | sed -E  s/^\\\\\*\ \(.+\)$/\(\\\\\1\)\ /`'
    local __prompt_tail="\[\033[35m\]$"
    local __last_color="\[\e[1;37m\]"
    __prompt_arguments="$__user $__cur_location $__git_branch_color$__git_branch$__prompt_tail$__last_color "
}
function write_hypens {
   local __cols=$((`tput cols` - 15))
   local __line=""
   for i in $(seq 1 $__cols); do
       __line=$__line"-"
   done
   echo $__line
}
function set_final_prompt {
   set_prompt_arguments
   local __failure='\[\e[01\;31m\]\`date +%T\` ✘ $(write_hypens) \:\('
   local __success='\[\e[01\;32m\]\`date +%T\` ✔ $(write_hypens) \:\)'
   PS1="\`if [ \$? = 0 ]; then echo $__success; else echo $__failure; fi\`\n$__prompt_arguments"
}
set_final_prompt

cat ~/.mac_profile
export PATH="/usr/local/opt/openjdk@11/bin:$PATH"
export CPPFLAGS="-I/usr/local/opt/openjdk@11/include"
