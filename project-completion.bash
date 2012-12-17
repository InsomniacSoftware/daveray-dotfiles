_project_completion() {
    local cur prev tasks
    cur="${COMP_WORDS[COMP_CWORD]}"
    tasks=`ls ~/.projects | awk '{sub(".sh$","");print}'`
    COMPREPLY=( $(compgen -W "${tasks}" -- ${cur}) )
    return 0
}
complete -F _project_completion p
