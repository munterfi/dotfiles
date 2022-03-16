# Create a new directory and enter it
function mkd() {
	mkdir -p "$@" && cd "$_";
}

# Compile, execute and remove executable
function gccexec() {
    file=$1
    executable="${file%%.*}"
    gcc -o $executable $file
    ./$executable
    rm $executable
}

# Search for process id
function p(){
    
    ppat=$1
    m=$2

    # Check monitor option
    if [ "$m" = "-m" ]; then
        echo "Juluu!"
        while :
        do
            s=$(ps aux | grep -i $ppat | grep -v grep)
            clear
            echo $s
            sleep 1
        done
    else
        ps aux | grep -i $ppat | grep -v grep
    fi
}

# Kill process by name pattern
function ka(){

    # Kill signal, defaults to 15 (1: SIGHUP, 9: SIGKILL, 15: SIGTERM, ...)
    klevel=${2:-15}

    echo -e "Searching processes with pattern '${1}'..."
    cnt=$(p $1 | wc | awk '{ print $1 }')      # Count of matching processes
    
    if [ $cnt -lt 1 ]
    then 
        echo "No matching processes found."
        exit 0
    else 
        p $1
       
        echo -e "\nTerminating ${cnt} processes..."
        ps aux | grep -i $1 | grep -v grep | awk '{print $2}' | xargs sudo kill -$klevel
       
        check=$(p $1 | wc | awk '{ print $1 }')   # Count again
        if [ $check -gt 0 ]
        then
            echo  "\nFailure! Not all matching processes terminated (try 'ka $1 -9')."
            p $1
        else
            echo -e "\nSuccess! All matching processes terminated."
        fi
    fi
}

# Create a .tar.gz archive, using `gzip` for compression
function targz() {
	local tmpFile="${@%/}.tar";
	tar -cvf "${tmpFile}" --exclude=".DS_Store" "${@}" || return 1;

	size=$(
		stat -f"%z" "${tmpFile}" 2> /dev/null;
		stat -c"%s" "${tmpFile}" 2> /dev/null;
	);

  local cmd="gzip";
	echo "Compressing .tar ($((size / 1000)) kB) using \`${cmd}\`…";
	"${cmd}" -v "${tmpFile}" || return 1;
	[ -f "${tmpFile}" ] && rm "${tmpFile}";

	zippedSize=$(
		stat -f"%z" "${tmpFile}.gz" 2> /dev/null;
		stat -c"%s" "${tmpFile}.gz" 2> /dev/null;
	);

	echo "${tmpFile}.gz ($((zippedSize / 1000)) kB) created successfully.";
}

# Extract most know archives with one command
extract () {
 if [ -f $1 ] ; then
  case $1 in
    *.tar.bz2)   tar xjf $1     ;;
    *.tar.gz)    tar xzf $1     ;;
    *.bz2)       bunzip2 $1     ;;
    *.rar)       unrar e $1     ;;
    *.gz)        gunzip $1      ;;
    *.tar)       tar xf $1      ;;
    *.tbz2)      tar xjf $1     ;;
    *.tgz)       tar xzf $1     ;;
    *.zip)       unzip $1       ;;
    *.Z)         uncompress $1  ;;
    *.7z)        7z x $1        ;;
    *)     echo "'$1' cannot be extracted via extract()" ;;
     esac
 else
     echo "'$1' is not a valid file"
 fi
}

# Determine size of a file or total size of a directory
function fs() {
	if du -b /dev/null > /dev/null 2>&1; then
		local arg=-sbh;
	else
		local arg=-sh;
	fi
	if [[ -n "$@" ]]; then
		du $arg -- "$@";
	else
		du $arg .[^.]* ./* | sort -h;
	fi;
}

# `tre` is a shorthand for `tree` with hidden files and color enabled, ignoring
# the `.git` directory, listing directories first. The output gets piped into
# `less` with options to preserve color and line numbers, unless the output is
# small enough for one screen.
tre () {
    tree -aC -I '.git|node_modules|bower_components|.idea' --dirsfirst "$@" | less -FRNX;
}

# git feature branch
function feature-start() { git checkout -b feature/$* develop }
function feature-merge() { (git checkout develop && git merge --no-ff feature/$* && git branch -d feature/$*) }
function bugfix-start() { git checkout -b bugfix/$* develop }
function bugfix-merge() { (git checkout develop && git merge --no-ff bugfix/$* && git branch -d bugfix/$*) }
function release-start() { git checkout -b release/$* develop }
function gup-set() { git push --set-upstream origin "$(git branch --show-current)" }
function gba-prune() { git fetch -p && for branch in $(git for-each-ref --format '%(refname) %(upstream:track)' refs/heads | awk '$2 == "[gone]" {sub("refs/heads/", "", $1); print $1}'); do git branch -D $branch; done }
