# AUTHOR: Rob Bednark
# vim: expandtab ts=4
################################################################################
### .bashrc
################################################################################

################################################################################
# oh-my-zsh BEGIN
################################################################################
enable_oh_my_zsh=false

HOSTNAME_COMPUTER_MOOVEL='mv-mbp13-rbednark'

if $enable_oh_my_zsh; then
    # Path to your oh-my-zsh configuration.
    ZSH=$HOME/.oh-my-zsh

    # Set name of the theme to load.
    # Look in ~/.oh-my-zsh/themes/
    # Optionally, if you set this to "random", it'll load a random theme each
    # time that oh-my-zsh is loaded.
    ZSH_THEME="robbyrussell"

    # Uncomment following line if you want red dots to be displayed while waiting for completion
    COMPLETION_WAITING_DOTS="true"

    # This should disable the title functionality in oh-my-zsh, but it is not
    # working for me.
    DISABLE_AUTO_TITLE='true'

    # Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
    # Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
    # Example format: plugins=(rails git textmate ruby lighthouse)
    plugins=(git)

    if echo $SHELL | grep zsh > /dev/null; then
        zsh_shell=true
        [ -f $ZSH/oh-my-zsh.sh ] && source $ZSH/oh-my-zsh.sh
        # Disable hostname completion.  I thought this might have been causing a lockup I see when I attempt certain filename completions, but it doesn't.
        zstyle ':completion:*' hosts off
        # This allows completing something in the middle of a word (see http://stackoverflow.com/questions/13341900/zsh-how-do-i-set-autocomplete-so-that-it-inserts-the-completion-when-cursor-is )
        bindkey '^i' expand-or-complete-prefix
    fi
fi

################################################################################
# oh-my-zsh END
################################################################################

# ANSI escape sequences terminal colors
ANSI_ESC_SEQ_BLUE="\[$(tput setaf 105)\]"
ANSI_ESC_SEQ_GREEN="\[$(tput setaf 2)\]"
ANSI_ESC_SEQ_RED="\[$(tput setaf 162)\]"
ANSI_ESC_SEQ_RESET="\[$(tput sgr0)\]"

if echo $SHELL | grep bash > /dev/null; then
    # Set the interactive shell prompt to [username@machinename working-directory mm/dd hh:mm:ss ]
    # \u@\h ==> username@machinename
    # \w ==> working-directory
    export PS1="${ANSI_ESC_SEQ_RED}\w ${ANSI_ESC_SEQ_GREEN}\$(git.branch.show) ${ANSI_ESC_SEQ_BLUE}\D{%m/%d} \t\n${ANSI_ESC_SEQ_RESET}$ "
fi
#
# e.g.,
# sara@LittleRed ~/bin Tue Oct 11 11:34:24$ 
#
if uname | grep Darwin  > /dev/null; then
    MacOSX=true
else
 alias ls="ls -CF --color"
    MacOSX=false
fi

if hostname | grep -i atlatl > /dev/null; then
    Atlatl=true
else   
    Atlatl=false
fi

if echo $SHELL | grep zsh > /dev/null; then
    # zsh prompt
    # %m - machine name; %d - current working directory; %@ - current time
    PS1='%m:%d %@ $ '
fi

# inc_append_history ==> Save every command before it is executed (this is different from bash's history -a solution):
# share_history ==> Retrieve the history file everytime history is called upon.
# append_history ==> If this is set, zsh sessions will append their history list to the history file, rather than replace it. Thus, multiple parallel zsh sessions will all have the new entries from their  history  lists added  to  the  history  file, in the order that they exit.

if type setopt > /dev/null 2>&1; then
    # Assert: this shell supports setopt (e.g., zsh)
    # When I start a new session, get the history of all sessions before it.  But once it's started, don't get any history from other sessions:
    setopt append_history no_inc_append_history no_share_history
else
    # bash
    # If this shell doesn't support setopt (like bash):
    # histappend => If the histappend shell option is enabled, the lines are appended to the history file, otherwise the history file is overwritten.
    shopt -s histappend
fi

# Show all lines of history, not just the last 15 lines.
alias hless="history|less"
alias htail="history|tail"

if type bindkey > /dev/null 2>&1; then
    # bind control-r to be the history search 
    bindkey '^R' history-incremental-search-backward
fi

# GIT_DIFF_OPTS -- -U0 -- set the number of lines of context to 0 lines (instead of default of 3)
# NOTE: uppercase "U", not lowercase!  :-)
export GIT_DIFF_OPTS=-U0

export DISPLAY='rbednark:0.0'
export DISPLAY=""
export DISPLAY=":0.0"
export EDITOR="/usr/bin/vim"
# less -R ==> Like  -r,  but only ANSI "color" escape sequences are output in "raw" form.  Unlike -r, the screen appearance is maintained correctly in most cases.
# less --LINE_NUMBERS ==> enable line numbers
export LESS="-iRX --LINE-NUMBERS --jump-target=.5" # -R ==> process color escape sequences correctly   -i ==> case insensitive search, unless UPPERCASE chars are searched
                   # -X ==> do NOT clear the screen on exit  --jump-target=.5 ==> show matches in the middle of the screen instead of the first line
                   # NOTE: -I will completely ignore case, even for uppercase searches
#export SHELL=/bin/bash
export VISUAL="/usr/bin/vim"
export SAVEHIST=80000 # max size in HISTFILE
if echo $SHELL | grep zsh > /dev/null; then
    # zsh
    # Added 2/8/13.  History was not getting saved on Atlatl Mac.  Not sure how it was getting saved on my Retina.
    alias history="history 1"  # by default, zsh history does not show entire history, so override and show all
    export HISTFILE=~/.zsh_history
    export HISTSIZE=32000 # max size internal history per session
else
    # bash
    export HISTSIZE=99999 # max size internal history per session
    export HISTFILESIZE=99999 # max size internal history per session
    #  HISTIGNORE
    #         A  colon-separated list of patterns used to decide which command lines should be saved on the history list.
    #         Each pattern is anchored at the beginning of the line and must match the complete line (no implicit `*'  is
    #         appended).   Each pattern is tested against the line after the checks specified by HISTCONTROL are applied.
    #         In addition to the normal shell pattern matching characters, `&' matches the previous  history  line.   `&'
    #         may  be escaped using a backslash; the backslash is removed before attempting a match.  The second and sub-
    #         sequent lines of a multi-line compound command are not tested, and are added to the history  regardless  of
    #         the value of HISTIGNORE.
    # & -- previous history line
    export HISTIGNORE="&:ls:[bf]g:exit:history"
fi
#export SHARE_HISTORY=1
# Uncommented APPEND_HISTORY 2/5/13
export APPEND_HISTORY=1 # Append rather than replace
#export INC_APPEND_HISTORY=1  
export HISTTIMEFORMAT="%m/%d/%y %a %T "

################################################################################
### Exports
################################################################################
export MANPATH="$MANPATH:/usr/man"
if $MacOSX; then
    # The path for the PostgreSQL Postgres.app from Heroku
    #export PATH="/Applications/Postgres.app/Contents/MacOS/bin:$PATH"
    #export PATH="$PATH:/Applications"
    :
fi
export PATH="/usr/local/bin:$PATH"
export PATH="$PATH:/bin"
#export PATH="$PATH:/cygdrive/c/Program Files/Java/jdk1.5.0_02/bin"
#export PATH="$PATH:/home/sara/bin"
#export PATH="$PATH:/cygdrive/c/Program Files/MySQL/MySQL Server 5.5/bin"
export PATH="$PATH:~/bin"
if $MacOSX; then
    # Python3
    export PATH="$PATH:/usr/local/Cellar/python3/3.2.3/bin"
    # export PATH="$(brew --prefix)/opt/python/libexec/bin:$PATH"
fi
export RCSINIT=" -zLT"  # RCSINIT - options that get prepended to rcs commands.  -z is to set the time zone.  LT is for local time.

## PYTHONPATH is searched by python for modules to import
#export PYTHONPATH="/fvt/tests/modules"
#export PYTHONPATH="~/selenium/selenium-python-client-driver-1.0.1"
##export PYTHONPATH="C:/cygwin/home/sara/selenium/selenium-python-client-driver-1.0.1"

if echo $OSTYPE | grep -i linux > /dev/null; then
 ## ASSERT: this is Linux
    export PATH="$PATH:/usr/bin"
    export PATH="$PATH:/sbin"
    export PATH="$PATH:/usr/sbin"
    export PATH="$PATH:/home/sara/bin"
else
    :
fi

# export AWS_ACCESS_KEY_ID='AKIAJME5CORBB3EJ3X5Q'
# export AWS_SECRET_ACCESS_KEY='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'
export OSU_API_KEY='be0ebeaa7260905173375e8e26611192cf1c2c61'

################################################################################
### Non-exports:
################################################################################

### Directories dependent on one another, or used for Dir's down below

CmdDatestamp='date +%Y.%m.%d_%H.%M.%S.%a'
if hostname | grep 'littlered-ubuntu' > /dev/null; then
    DirSaraDocs="~/windows.sara.documents"
else
    DirSaraDocs="/cygdrive/c/Users/sara/Documents"
fi
IBM=false

if hostname | grep -i $HOSTNAME_COMPUTER_MOOVEL > /dev/null; then
    DirDropbox=~/dropbox.symlink
else
    DirDropbox=~/Dropbox
fi
DirBin="$DirDropbox/bin"
export PATH=$PATH:$DirDropbox/bin
DirGit=$DirDropbox/git
DirGitLocal="$HOME/local.git"
DirRob="$DirSaraDocs/Rob"
# This is what it was on HOME-PC desktop:
#DirRbednark="/cygdrive/c/cygwin/home/sara"
DirRbednark=~
DirTopPC="$HOME"
DirTopUnix="/home/rbednark"
DirTxt="$DirTopPC/txt"
DirDoc=$DirDropbox/Rob/doc

DirAddToQuizme="$DirDropbox/add_to_quizme"
DirBackup="$DirTopPC/backup"
DirBednarkCom="$DirDropbox/Rob/bednark.com"
DirC="/cygdrive/c"
DirCheckin="$DirRbednark/checkin"
DirFamilyTree="$DirDropbox/family.tree"
DirFamilyTreeReports="$DirFamilyTree"
DirGithub=~/git
if $MacOSX; then
    DirIphoneApps="~/Music/iTunes/iTunes Media/Mobile?Applications"
fi
DirLearn="$DirBin/learn"
DirNodeModulesLocal=~/local_node_modules
DirOptionTables="$DirRbednark/option.tables"
DirPicts="$DirRbednark/picts"
DirPublicHtml="$DirRbednark/public_html"
DirResume="$DirDropbox/rob.resume"
DirQuiz="$DirLearn/quiz.python/db"
DirQuizMe=$DirGit/quizme_website
DirReadOnly="$DirRbednark/read.only"
DirRepoRobBednarkGithubIO=~/repos.rob/robbednark.github.io
DirSync="$DirRbednark/sync"
DirUnixConfigFiles="$DirDropbox/Rob/unix.config.files"

URL_robbednark_github_io='https://robbednark.github.io'

BinQuote="$DirBin/get.random.quote.pl"

FileAbout="$DirBednarkCom/cpp/aboutMe.cpp"
FileAccomplishments="$DirDoc/accomplishments.txt"
FileBlog="$DirDoc/blog.txt"
FileBlogHtml="$DirBednarkCom/cpp/blog.cpp"
FileBooknotes="$DirBednarkCom/cpp/bookNotes.cpp"
FileContactInfo="$DirBednarkCom/cpp/contact.info.cpp"
FileDiary="$DirDoc/diary.txt"
FileDoc="$DirDoc/doc.txt"
FileEmailAddrs="$DirDoc/aliases.text"
FileEstimates="$DirDoc/estimates.txt"
FileEmailGroups="$DirBednarkCom/cpp/email.groups.cpp"
FileFamilyTreeHtml="$DirDropbox/family.tree/Html/I1.html"
FileHuawei="$DirDoc/huawei.notes.txt"
FileHumor="$DirBednarkCom/cpp/humor.cpp"
FileIndex="$DirRepoRobBednarkGithubIO/index.html"
FileInformixEmployees="$DirPublicHtml/employees.html"
FileJ="$DirDoc/j.txt"
FileJQuizCopy="$DirQuiz/j.txt"
FileJTmp="$DirDoc/j.interim.txt"
FileJTmpQuizCopy="$DirQuiz/j.interim.txt"
FileLearnTodo="$DirQuiz/db_want_to_learn_find_out_get_answers_ask_google_helpouts_stackoverflow_todo.txt"
FileMyPsychology="$DirDoc/my.psychology.txt"
if hostname | grep 'littlered-ubuntu' > /dev/null; then
    DirCygwin="~/windows.cygwin.home.sara"
fi
FilePeopleHtml="$DirBednarkCom/people.I.know.html"
FilePeopleTxt="$DirDoc/people.I.know.txt"
FilePhone="$DirDoc/phone.nums.txt"
FilePicts="$DirTxt/sent.list.txt"
FilePingOutput=~/tmp/ping.monitor.$$
FilePingSymlinkActive=~/tmp/ping.monitor.active
FileQuotes="$DirRepoRobBednarkGithubIO/quotes.html"
FileRc="$DirUnixConfigFiles/.bashrc"
FileRecommendations="$DirBednarkCom/cpp/i.recommend.cpp"
FileSitemap="$DirBednarkCom/sitemap.xml"
FileViolinStrings="$DirBednarkCom/cpp/violin.strings.survey.cpp"
FileSiteMapHtml="$DirBednarkCom/cpp/site.map.cpp"
FileSiteMapXml="$DirBednarkCom/sitemap.xml"
FileSoftwareQuotes="$DirBednarkCom/cpp/software.quotes.cpp"
FileStocks="$DirDoc/sto.txt"
FileStockNotes="$DirDoc/stock.notes.txt"
FileStories="$DirBednarkCom/cpp/stories.cpp"
FileToday="$DirDoc/today.txt"
FileTodayNew="$DirBin/todo_db.py"
FileToDo="$DirDoc/todo.txt"
FileVimrc="$DirUnixConfigFiles/.vimrc"
FileVocab="$DirBednarkCom/cpp/vocab.cpp"

if $MacOSX; then
    alias open.adobe.reader='open -a "Adobe Reader"'
fi

alias family.tree.firefox="firefoxfile $FileFamilyTreeHtml"
alias family.tree.chrome="open -a google\ chrome $FileFamilyTreeHtml"

alias c=clear
alias c.="cd .."
alias c-="cd -"
alias cdbednarkcom="cd $DirBednarkCom"
alias cdbuddyup="cd $DirGitLocal/buddyup.github.adevore"
alias cddada="cd $DirDropbox/Rob/dada"
alias cd.iphone.apps="cd ~/Music/iTunes/iTunes?Media/Mobile?Applications"
alias cddockerlearn="cd $DirDropbox/bin/learn/dir-learn-docker"
alias cddockercomposelearn="cd $DirDropbox/bin/learn/dir-learn-docker-compose"
alias cddjango="cd $DirDropbox/bin/learn/dir.learn.django.projects"
alias cddjangocode="cd /home/sara/local.dir.learn.django.projects/my.venv/lib/python2.7/site-packages/django"
alias cddoc="cd $DirDoc"
alias cddropbox="cd $DirDropbox"
alias cdfam="cd $DirFamilyTree"
alias cdgit="cd $DirGit"
alias cdisbullshit="cd $DirGitLocal/isbullshit-crawler"
alias cdjavascript="cd $DirLearn/javascript"
alias cdlearn="title learn; cd $DirLearn"
alias cdlearngit="cd $DirLearn/git"
#aliascdmusic="cd /cygdrive/c/Documents\ and\ Settings/All\ Users/Documents/My\ Music/"
alias cdnode="cd $DirLearn/node-projects"
#aliascdoption="cd $DirOptionTables"
alias cdosqa="cd $DirGitLocal/osqa"
alias cdosu="cd $DirGit/osu-game-stats-top-10k-players; workon osu-game-stats-top-10k-players"
alias cdpicts="cd $DirPicts"
alias cdpsu="cd $DirDropbox/Rob/psu.online.map"
alias cdpublic="cd $DirPublicHtml"
alias cdpydoc="cd $DirDropbox/Rob/python.doc/python-2.7.2-docs-text"
alias cdquantopian="cd $DirDropbox/quantopian"
alias cdquiz="title quiz; cd $DirQuiz"
alias cdquizme="cd $DirQuizMe; pipenv shell"
alias cdreact="cd $DirLearn/learn-react/create-react-app"
alias cdresume="cd $DirResume"
alias cdrobbednark-github-io-website="cd $DirRepoRobBednarkGithubIO"
alias cdscrapy="cd $DirLearn/scrapy"
#aliascdsel="title ebento.py; cd ~/huawei/selenium"
#aliascdstax="cd $DirLearn/stax; pwd; ls"
alias cdstatements="cd $DirDropbox/Statements.and.bills"
alias cdsurvey="cd $DirDropbox/mike.ames.survey/"
alias cdsync="cd $DirSync"
#aliascdtestadm="cd $DirTestadm; ls"
alias cdtxt="cd $DirTxt"
alias cdunixconfigfiles="cd $DirUnixConfigFiles"
alias cdvagrant="cd ~/Desktop/vagranttest"

################################################################################
# #Moovel:
################################################################################
DirMoovel=$DirDropbox/moovel
DirMoovelLocal=~/moovel
DirMoovelAgencyObjects=$DirMoovelLocal/agency-objects
DirMoovelRepos=~/repos
DirMoovelReposAll=~/repos.all-gamma-services
DirMoovelReposClients=~/repos.clients
DirMoovelReposDevops=~/repos.devops
DirMoovelReposDocker=$DirMoovelRepos/na-transitutils-docker/src/app
DirMoovelReposEngineering=~/repos.engineering
DirMoovelReposGamma=~/repos.gamma
DirMoovelReposPayment=~/repos.journaling
DirMoovelReposOther=~/repos.other
DirMoovelGammaDocker=$DirMoovelRepos/gamma-docker-4
alias cdmoovel="cd $DirMoovel"
alias cdmoovel-agency-object-download="cd $DirMoovelRepos/download-agency-objects"  # DELETE this after I get my create*.sh scripts working in fare-catalogs

# moovel docs
alias cddocs-moovel="cd $DirMoovelReposEngineering/na-engineering-docs"

# moovel gamma-docker
alias cddocker="cd $DirMoovelGammaDocker"
alias cddocker-fare-catalogs="cd $DirMoovelGammaDocker/src/data/fare-catalogs"
alias cddocker-gamma-catalog="cd $DirMoovelGammaDocker/src/app/gamma-catalog"

# moovel e2e Tests
alias cde2e-tests="cd $DirMoovelReposGamma/na-e2e-service-tests"

# moovel micro dependencies
alias cdclient-response="cd $DirMoovelReposGamma/na-mv-client-response"
alias cderror="cd $DirMoovelReposGamma/na-mv-error"
alias cdlogger="cd $DirMoovelReposGamma/na-gamma-logger"
alias cdrequest="cd $DirMoovelReposGamma/na-mv-request"

# config / proxy
alias cdrevproxy="cd $DirMoovelReposGamma/gamma-config-revproxy"

# database / db
alias cddbagency="cd $DirMoovelReposGamma/db-agency"
alias cddbbaseschema="cd $DirMoovelReposGamma/db-base-schema"

# Rip City / catalog
alias cdagency-config="cd $DirMoovelReposGamma/agency-config"
#alias cdagency-objects="cd $DirMoovelLocal/agency-objects"
alias cdagency-objects="cd $DirMoovelReposGamma/na-agency-objects"
alias cd-agency-map="cd $DirMoovelReposGamma/na-agency-map"
alias cdagency-sync="cd $DirMoovelReposGamma/gamma-agency-sync"
alias cdcatalog="cd $DirMoovelReposGamma/gamma-catalog"
alias cd-download-agency-objects="cd $DirMoovelReposGamma/na-download-agency-objects"
alias cdfare-catalogs="cd $DirMoovelReposGamma/fare-catalogs"
alias cdproduct="cd $DirMoovelReposGamma/gamma-product"
alias cdsecurity-code="cd $DirMoovelReposGamma/gamma-security-code"
alias cdticket-animation="cd $DirMoovelReposAll/gamma-ticket-animation"
alias cdv="cd $DirMoovelReposGamma/na-verve-web"
alias cdv2="cd $DirMoovelReposGamma/na-verve-web-2"
alias cdv3="cd $DirMoovelReposGamma/na-verve-web-3"
alias cdv4="cd $DirMoovelReposGamma/na-verve-web-4"
alias cdgateway-verve="cd $DirMoovelReposGamma/gateway-verve"

# Trip Utilities:
alias cd-docker-transitutils="cd $DirMoovelRepos/na-transitutils-docker"
# alias cdgateway="cd $DirMoovelReposDocker/na-gateway-python"
alias cdgtfsrt="cd $DirMoovelReposDocker/na-gtfsrt-py"
alias cdgtfsrealtimejson="cd ~/repos.other/gtfs_realtime_json"
alias cdingestion="cd $DirMoovelReposDocker/na-ingestionserver-python"
alias cdmobility="cd $DirMoovelReposDocker/na-mobility-python"
alias cdproviders="cd $DirMoovelReposDocker/na-providers-python"
alias cdrrrr="cd $DirMoovelReposDocker/rrrr"
alias cdtest="cd $DirMoovelReposDocker/na-trip-utils-api-tests"
alias cdtransit="cd $DirMoovelReposDocker/na-transitplusplus-python"
alias cdtransitfeed="cd $DirMoovelReposOther/transitfeed/examples"

# Ventra Trip Planner / Pace GTFS ingestion
alias cdpace-old="cd $DirMoovelLocal/gtfs/pace"
alias cdpace="cd $DirMoovelRepos/scheduled-tasks/ventra-gtfs-import/filter-pace-gtfs"
alias cdgtfspace="cd $DirMoovelRepos/gtfs-pace-import"

# ticket
alias cdticket="cd $DirMoovelReposGamma/gamma-ticket"

# payment/reporting/journaling
alias cdlambda="cd $DirMoovelReposPayment/journal-lambda"
alias cdpayment="cd $DirMoovelReposPayment/gamma-payment"
alias cdpurchase="cd $DirMoovelReposPayment/gamma-purchase"

# misc
alias cdscheduled-tasks="cd $DirMoovelRepos/scheduled-tasks/ventra-pace-gtfs-filter"

# misc devops:
alias cdawsdeploy="cd $DirMoovelReposDevops/gamma-aws-deploy"
alias cdjenkins="cd $DirMoovelReposDevops/jenkins-dev"

# node trip-plannner
alias cdtrip-planner="cd $DirMoovelRepos/trip-planner"

alias cdenv-shared-dev="cd $DirMoovelReposDevops/env-shared-dev"
alias cdenv-shared-prod="cd $DirMoovelReposDevops/env-shared-prod"
alias cdenv-shared-prod-east="cd $DirMoovelReposDevops/env-shared-prod-east"
alias cdenv-shared-stage="cd $DirMoovelReposDevops/env-shared-stage"
alias cdenv-stage-east="cd $DirMoovelReposDevops/env-stage-east"
alias cdenv-shared-test="cd $DirMoovelReposDevops/env-shared-test"
alias cdenv-ventra-prod="cd $DirMoovelReposDevops/env-ventra-prod"

# client apps
alias cdandroid="cd $DirMoovelReposClients/na-ridetap-android"
alias cdios="cd $DirMoovelReposClients/na-ridetap-ios"
alias cdthe.app.factory="cd $DirMoovelReposClients/na-app-factory-titanium"

function curl-agency-sync() {
    host=$1
    scope=$2
    user_agent=$3
    version=$4
    query_string=$5
    curl --request GET \
    --url "${host}/v2/agency-sync/sync${query_string}" \
    --header "accept: version=${version}" \
    --header "x-gs-scope: ${scope}" \
    --header "x-gs-user-agent: {\"devicePlatform\": \"${user_agent}\"}" | jq .
}

function curl-agency-sync-all() {
    set -x;
    curl-agency-sync-bart-prod
    curl-agency-sync-bart-stage
    curl-agency-sync-caltrain-prod
    curl-agency-sync-houston-dev
    curl-agency-sync-houston-prod
    curl-agency-sync-metrotransit-dev
    curl-agency-sync-metrotransit-prod
    curl-agency-sync-octa-prod
    curl-agency-sync-octa-prod-reduced
    curl-agency-sync-san-diego-prod
    curl-agency-sync-santa-clara-vta-prod
    curl-agency-sync-sfmuni-prod
    set +x
}
function curl-agency-sync-atlanta-streetcar-prod-ios() {
    curl-agency-sync "https://atlanta-streetcar.transitsherpa.com" "atlanta-streetcar-prod" "ios" 2
}
function curl-agency-sync-baltimore-docker-null() {
    curl-agency-sync "http://localhost:80" "baltimore-mta-docker" "null" 3
}
function curl-agency-sync-baltimore-test-null() {
    curl-agency-sync "https://baltimore-mta-test.gslabs.us" "baltimore-mta-test" "null" 3
}
function curl-agency-sync-bart-dev() {
    curl-agency-sync "https://bart-dev.gslabs.us" "bart-dev" "ios" 3
}
function curl-agency-sync-bart-docker() {
    curl-agency-sync "http://localhost:80" "bart-docker" "ios" 3
}
function curl-agency-sync-bart-prod() {
    curl-agency-sync "https://bart.transitsherpa.com" "bart-prod" "ios" 3
}
function curl-agency-sync-bart-stage() {
    curl-agency-sync "https://bart-stage.gslabs.us" "bart-stage" "ios" 3
}
function curl-agency-sync-caltrain-docker() {
    curl-agency-sync "http://localhost:80" "caltrain-docker" "ios" 3
}
function curl-agency-sync-caltrain-prod() {
    curl-agency-sync "https://caltrain.transitsherpa.com" "caltrain-prod" "ios" 3
}
function curl-agency-sync-hampton-roads-hrt-test() {
    curl-agency-sync "https://hampton-roads-hrt-test.gslabs.us" "hampton-roads-hrt-test" "ios" 3
}
function curl-agency-sync-houston-dev() {
    curl-agency-sync "https://houston-metro-dev.gslabs.us" "houston-metro-dev" "ios" 2
}
function curl-agency-sync-houston-prod() {
    curl-agency-sync "https://ridemetro.transitsherpa.com" "houston-metro-prod" "ios" 2
}
function curl-agency-sync-metrotransit-dev() {
    curl-agency-sync "https://metrotransit-dev.gslabs.us" "metrotransit-dev" "ios" 3
}
function curl-agency-sync-metrotransit-prod() {
    curl-agency-sync "https://metrotransit.transitsherpa.com" "metrotransit-prod" "ios" 3
}
function curl-agency-sync-octa-docker() {
    curl-agency-sync "http://localhost:80" "octa-docker" "ios" 2
}
function curl-agency-sync-octa-prod() {
    curl-agency-sync "https://ocbus.transitsherpa.com" "octa-prod" "ios" 2
}
function curl-agency-sync-octa-prod-reduced() {
    curl-agency-sync "https://ocbus.transitsherpa.com" "octa-prod" "ios" 2 '?fare=reduced'
}
function curl-agency-sync-san-diego-dev-android() {
    curl-agency-sync "https://san-diego-dev.gslabs.us" "san-diego-dev" "android" 3
}
function curl-agency-sync-san-diego-dev-ios() {
    curl-agency-sync "https://san-diego-dev.gslabs.us" "san-diego-dev" "ios" 3
}
function curl-agency-sync-san-diego-dev-null() {
    curl-agency-sync "https://san-diego-dev.gslabs.us" "san-diego-dev" "null" 3
}
function curl-agency-sync-san-diego-docker-android() {
    curl-agency-sync "http://localhost:80" "san-diego-docker" "android" 3
}
function curl-agency-sync-san-diego-docker-ios() {
    curl-agency-sync "http://localhost:80" "san-diego-docker" "ios" 3
}
function curl-agency-sync-san-diego-docker-null() {
    curl-agency-sync "http://localhost:80" "san-diego-docker" "null" 3
}
function curl-agency-sync-san-diego-prod-android() {
    curl-agency-sync "https://compass.transitsherpa.com" "san-diego-prod" "android" 3
}
function curl-agency-sync-san-diego-prod-ios() {
    curl-agency-sync "https://compass.transitsherpa.com" "san-diego-prod" "ios" 3
}
function curl-agency-sync-san-diego-prod-null() {
    curl-agency-sync "https://compass.transitsherpa.com" "san-diego-prod" "null" 3
}
function curl-agency-sync-san-diego-stage-android() {
    curl-agency-sync "https://san-diego-stage.gslabs.us" "san-diego-stage" "android" 3
}
function curl-agency-sync-san-diego-stage-ios() {
    curl-agency-sync "https://san-diego-stage.gslabs.us" "san-diego-stage" "ios" 3
}
function curl-agency-sync-san-diego-stage-null() {
    curl-agency-sync "https://san-diego-stage.gslabs.us" "san-diego-stage" "null" 3
}
function curl-agency-sync-san-diego-test-android() {
    curl-agency-sync "https://san-diego-test.gslabs.us" "san-diego-test" "android" 3
}
function curl-agency-sync-san-diego-test-ios() {
    curl-agency-sync "https://san-diego-test.gslabs.us" "san-diego-test" "ios" 3
}
function curl-agency-sync-san-diego-test-null() {
    curl-agency-sync "https://san-diego-test.gslabs.us" "san-diego-test" "null" 3
}
function curl-agency-sync-san-antonio-via-prod-android() {
    curl-agency-sync "https://via.transitsherpa.com" "san-antonio-via-prod" "android" 3
}
function curl-agency-sync-san-antonio-via-prod-ios() {
    curl-agency-sync "https://via.transitsherpa.com" "san-antonio-via-prod" "ios" 3
}
function curl-agency-sync-san-antonio-via-stage-ios() {
    curl-agency-sync "https://san-antonio-via-stage.gslabs.us" "san-antonio-via-stage" "ios" 3
}
function curl-agency-sync-santa-clara-vta-docker() {
    curl-agency-sync "http://localhost:80" "santa-clara-vta-docker" "ios" 3
}
function curl-agency-sync-santa-clara-vta-prod() {
    curl-agency-sync "https://vtaezfare.transitsherpa.com" "santa-clara-vta-prod" "ios" 3
}
function curl-agency-sync-san-diego-all() {
    curl-agency-sync-san-diego-dev-android | jq . > $DirMoovelAgencyObjects/san-diego/$(datestamp)-san-diego-dev-android.json
    curl-agency-sync-san-diego-dev-ios | jq . > $DirMoovelAgencyObjects/san-diego/$(datestamp)-san-diego-dev-ios.json
    curl-agency-sync-san-diego-dev-null | jq . > $DirMoovelAgencyObjects/san-diego/$(datestamp)-san-diego-dev-null.json
}
function curl-agency-sync-sfmuni-prod() {
    curl-agency-sync "https://sfmta.transitsherpa.com" "sfmuni-prod" "ios" 2
}
function curl-agency-sync-sfmuni-prod-v3() {
    curl-agency-sync "https://sfmta.transitsherpa.com" "sfmuni-prod" "ios" 3
}
function curl-agency-sync-vre-prod-v1() {
    curl-agency-sync "https://vre.transitsherpa.com" "vre" "ios" 1
}

function curl-csvs-gamma-catalog() {
    # read -p "Input the agency (octa)" _agency
    _zipfile="rbednark.csvs.zip"
    _dir_zipfile="/tmp"
    (
    set -x;
    cddocker;
    docker exec gamma-catalog bash -c "curl --header 'x-gs-scope: san-diego-docker' --url 'http://localhost:5000/csv?workflowId=1' > /tmp/$_zipfile";
    rm -f /tmp/$_zipfile;
    docker cp gamma-catalog:/tmp/$_zipfile /tmp;
    ls -l /tmp/$_zipfile;
    unzip -l /tmp/$_zipfile;
    cd /tmp;
    rm -fr rbednark-csvs;
    mkdir rbednark-csvs;
    cd rbednark-csvs;
    unzip /tmp/$_zipfile;
    )
}

alias curl-catalog-product-id="curl 'https://bart-dev.gslabs.us/v2/catalog/product/1' -H 'x-gs-scope: bart-dev'"
alias curl-catalog-products="curl 'https://bart-dev.gslabs.us/v2/catalog/products' -H 'x-gs-scope: bart-dev'"
alias curl-catalog-products-docker="curl -H 'x-gs-scope: houston-metro-docker' http://gamma-catalog:5000/products"
alias docker.stats="docker stats --no-trunc --no-stream "
#alias docker.stats.names="docker stats $(docker ps | awk \'{if(NR>1) print $NF}\')"  
# see container names instead of hashes
alias addrs.dev="$DirLearn/parse_moovel_instances.py"
alias psql.ridescout.providers="psql -h ridescoutgeo.cixz9hxezij4.us-west-2.rds.amazonaws.com -U ridescout -W providers"
alias moovel-ssh-host="~/bin/ssh-host.py"
alias ssh.rs.mobility="ssh ubuntu@beta.mobility.ridescout.com -i ~/repos/na-providers-python/ridescout-backend-developer.pem.txt"
alias ssh.rs.providers="ssh ubuntu@52.27.32.0 -i ~/repos/na-providers-python/ridescout-backend-developer.pem.txt"
alias ssh.rs.gateway="ssh ubuntu@54.191.144.62 -i ~/repos/na-providers-python/ridescout-backend-developer.pem.txt"
# alias ssh.rs.transit="ssh ubuntu@54.191.119.117 -i ~/repos/na-providers-python/ridescout-backend-developer.pem.txt"
alias ssh.rs.ingestion="ssh ubuntu@ec2-52-88-39-172.us-west-2.compute.amazonaws.com -i $DirMoovel/certs/ridescoutingestion.pem"
alias ssh.rs.transit="ssh ubuntu@ec2-54-191-119-117.us-west-2.compute.amazonaws.com -i $DirMoovel/certs/ridescoutingestion.pem"
alias scp.jump.server="~/repos.devops/it/aws/tools/vpc-tunnel.sh development 172.18.1.21 9998; sleep 1.5; scp -P 9998 127.0.0.1:myfile ."
alias ssh.jump.server="~/repos.devops/it/aws/tools/vpc-tunnel.sh development 172.18.1.21 9998; sleep 1.5; ssh -p 9998 127.0.0.1"
moovel_prod="https://rs-gateway.transitsherpa.com"
moovel_shared_dev="https://rs-gateway-dev.gslabs.us"
coords_san_antonio='lat=29.42&lng=-98.48'
alias curl.ridesnear.local.octa='curl "http://0.0.0.0:48002/city/rides-near/?lat=33.699841&lng=-117.759218&api_key=backendrules&format=json&limit=3&presentation_demo=true"'
alias curl.busstops.shareddev.san_antonio='curl "https://rs-gateway-dev.gslabs.us/transit/bus-stops/?api_key=backendrules&lat=29.414695&lng=-98.436579&radius=2000&end=29.414695,-98.436579" | json_pp | less'
alias curl.ridesnear.shareddev.octa='curl "https://rs-gateway-dev.gslabs.us/city/rides-near/?lat=33.699841&lng=-117.759218&api_key=backendrules&format=json&limit=3&presentation_demo=true" | json_pp | less'
alias curl.ridesnear.prod.octa.at.zipcar='curl "https://rs-gateway.transitsherpa.com/city/rides-near/?lat=33.672080695117245&lng=-117.84223858968812&api_key=backendrules&format=json&limit=3&presentation_demo=true" | json_pp | less'
alias curl.ridesnear.shareddev.octa.at.zipcar='curl "https://rs-gateway-dev.gslabs.us/city/rides-near/?lat=33.672080695117245&lng=-117.84223858968812&api_key=backendrules&format=json&limit=3&presentation_demo=true" | json_pp | less'
alias curl.ridesnear.shareddev.portland='curl "https://rs-gateway-dev.gslabs.us/city/rides-near/?lat=45.5199&lng=-122.6799&api_key=backendrules&format=json&limit=3&presentation_demo=true" | json_pp | less'
alias curl.providersnear.prod.portland='curl "https://rs-gateway.transitsherpa.com/city/providers-near/?radius=3000&lat=45.5199&lng=-122.6799&api_key=backendrules&format=json&limit=3&presentation_demo=true" | json_pp | less'
alias curl.providersnear.shareddev.portland='curl "https://rs-gateway-dev.gslabs.us/city/providers-near/?radius=3000&lat=45.5199&lng=-122.6799&api_key=backendrules&format=json&limit=3&presentation_demo=true" | json_pp | less'
alias curl.providersnear.shareddev.octa='curl "https://rs-gateway-dev.gslabs.us/city/providers-near/?api_key=7e03125622b5d4c262d1c02012e9f200&radius=3000&presentation_demo=true&lat=33.683947&format=json&lng=-117.794694" | json_pp | less'
alias curl.providersnear.prod.octa='curl "https://rs-gateway.transitsherpa.com/city/providers-near/?api_key=7e03125622b5d4c262d1c02012e9f200&radius=3000&presentation_demo=true&lat=33.683947&format=json&lng=-117.794694" | json_pp | less'
alias curl.providersnear.prod.san-antonio='curl "https://rs-gateway.transitsherpa.com/city/providers-near/?api_key=7e03125622b5d4c262d1c02012e9f200&radius=3000&presentation_demo=true&lat=29.42&format=json&lng=-98.48" | json_pp | less'
alias curl.providersnear.shared-dev.san-antonio='curl "https://rs-gateway-dev.gslabs.us/city/providers-near/?api_key=7e03125622b5d4c262d1c02012e9f200&radius=3000&presentation_demo=true&lat=29.42&format=json&lng=-98.48" | json_pp | less'
alias curl.ridesnear.shared-dev.san-antonio='curl "${moovel_shared_dev}/city/rides-near/?${coords_san_antonio}&api_key=backendrules&format=json&limit=3&presentation_demo=true" | json_pp | less'
alias curl.ridesnear.prod.san-antonio='curl "${moovel_prod}/city/rides-near/?${coords_san_antonio}&api_key=backendrules&format=json&limit=3&presentation_demo=true" | json_pp | less'
alias curl.instances.shareddev.raw='curl "https://dashboard-shared-dev.gslabs.us/gamma-status/instances"'
alias curl.instances.shareddev='curl "https://dashboard-shared-dev.gslabs.us/gamma-status/instances" | json_pp | less'

alias moovel-mysqldump-schema="mysqldump -h 0.0.0.0 -P 23306 -u root -p123 --no-data transitsherpa_san_diego"
alias moovel-vi-schema="vim $DirMoovelLocal/schemas/latest-schema.sql"

alias vmoovel-perf-reviews="vici $DirMoovel/perf-reviews.txt"
################################################################################
# End #Moovel
################################################################################

################################################################################
# Postgres
################################################################################
alias postgres.grep.ignore="egrep -v 'lock of type ShareLock|Connection reset by peer|GMT LOG:  duration:'"

alias ci="ci -zLT"
# I think "cmd" works for the default cygwin window, but not for rxvt
#alias cls="cmd /c cls"
# The following echo sequence works for rxvt.
alias cls="echo -ne '\033c'" 
alias co="co -zLT"
alias cp="cp -ip "
alias curl.headers="curl --include"
alias curl.status.code="curl --write-out 'http_code=[%{http_code}]'"
alias curl.status.code.2="curl --include"
alias curl.verbose="curl -v --write-out 'http_code=[%{http_code}] \nlocal_ip=[%{local_ip}]; remote_ip=[%{remote_ip}]\nredirect_url=[%{redirect_url}]\nsize_download=[%{size_download}] size_header=[%{size_header}] size_request=[%{size_request}] size_upload=[%{size_upload}]\nspeed_download=[%{speed_download}] bytes per second; speed_upload=[%{speed_upload}] bytes per second \ntime_appconnect=[%{time_appconnect}] time_connect=[%{time_connect}] seconds; time_namelookup=[%{time_namelookup}] time_total[%{time_total}] seconds; '"

alias datestamp='date +%Y.%m.%d.%a.%H.%M.%S'
alias dc='docker-compose'
alias dclogs='docker-compose logs --timestamps --follow'
alias dcp="docker-compose ps"
alias diffbednarkcom="diff -r $DirBednarkCom /tmp/bednark.com"
alias dotrc="source $FileRc"

alias finddropboxconflicted='find $DirDropbox | grep conflicted'
alias findex="ls -l | grep '^...x'"
if uname | grep -i linux > /dev/null; then
    true
elif $MacOSX; then
    alias chrome="open -a Google\ Chrome"
    alias chrome-canary="/Applications/Google\ Chrome\ Canary.app/Contents/MacOS/Google\ Chrome\ Canary"
    #alias firefox="open /Applications/"
    :
else
    alias firefox="/cygdrive/c/Program\ Files\ \(x86\)/Mozilla\ Firefox/firefox.exe"
fi

################################################################################
# #git short aliases
################################################################################
alias ga="git add"
alias gb="git branch"
alias gca="git commit -a"
alias gcaf="git commit -a --fixup"  # need to supply a commit-ish
alias gcafh="git commit -a --fixup HEAD"
alias gcf="git commit --fixup"
alias gch="git checkout"
alias gch-="git checkout -"
alias gchd="git checkout development"
alias gchm="git checkout master"
alias gco="git commit"
alias gcof="git commit --fixup"
alias gd="git diff --unified=0"
alias gdc="git diff --cached --unified=0"
alias gf="git fetch"
alias gg="git grep"
alias gl="git log -n5 --abbrev-commit --decorate --first-parent --no-merges"
alias glp="git log -p -n5 --abbrev-commit --decorate --first-parent --no-merges -U0"
alias gpf="git push -f"
alias gpul="git pull"
alias gpus="git push"
alias gr="git rebase -i --autosquash"  # need to supply a commit-ish
alias gra="git rebase -i --autosquash HEAD~20"
alias grh="git reset --hard"
alias gs="git status"
alias grep="grep --color"

################################################################################
# #git long aliases
################################################################################
#alias git.show.date.last.commit="git show --quiet --pretty='%cd' --no-pager  # just show commit date, and don't use a pager (e.g., less)
alias git.branch.mv.rename.remote="echo '
1. Rename your local branch.
     If you are on the branch you want to rename:
         git branch -m new-name
     If you are on a different branch:
         git branch -m old-name new-name
 2. Delete the old-name remote branch and push the new-name local branch.
     git push origin :old-name new-name
 3. Reset the upstream branch for the new-name local branch.
     Switch to the branch and then:
         git push origin -u new-name
'"
alias git.branch.rm.on.remote.repo="git push origin --delete"  # add name of branch to remove
alias git.checkout.cp.files.from.other.branch="echo 'git checkout other-branch my-file1 my-file2 my-subdir'"
alias git.checkout.undo.modifications.to.working.file="echo 'To undo changes to a file (they will be lost): \"git checkout my-file\"'"
alias git.diff.csv.word.diff="git diff --word-diff --word-diff-regex=,"
alias git.diff.exclude.a.file="echo git diff master...original . ':(exclude)package-lock.json'"
alias git.diff.filenames.change.summary="git diff --stat"
alias git.diff.merge.commit="echo find 'Merge: 7022ea3 6459148' from the merge commit and add 3 dots: 'git diff 7022ea3...67459148'" 
alias git.ls.filenames.ignored='git status --ignored'
alias git.ls.filenames.modified='git diff --name-only --diff-filter=M'
alias git.ls.filenames.modified.and.new="git.ls.filenames.new.untracked; git.ls.filenames.modified"
alias git.ls.filenames.new.untracked="git ls-files . --exclude-standard --others"
alias git.ls.filenames.staged="git diff --name-only --cached"
alias git.log="(set -x; git log --all --graph --oneline --abbrev-commit  --decorate; set +x)"
alias git.log.abbrev.short.commit.hash="git log --abbrev-commit"
alias git.log.filenames.changed="git log --name-only"
alias git.log.filenames.change.summary="git log --stat"
alias git.log.filenames.AMD="git log --stat"
alias git.log.grep.log.messages="git log --grep"
alias git.log.authors="(set -x; git log --pretty=format:'%ad %an')"  # author-date, author-name
alias git.log.branches='git log --graph --full-history --all --pretty=format:"%h%x09%d%x20%s"'
alias git.log.branches.color='git log --graph --full-history --all --color --pretty=format:"%x1b[31m%h%x09%x1b[32m%d%x1b[0m%x20%s"'
alias git.log.commit.message.only='git log --format=%B -n 1'
alias git.log.limit.commits='git log --max-count=2'
alias git.log.merge.commit.files.changes='git log -m -1 --name-only --pretty="format:"'  # need to specify a commit hash
alias git.log.show.commits.in.merge.commit='echo "git log commit1..commit2 (get commit hashes from merge commit via "git log" or "git show")"'
alias git.log.show.commits.on.branch.b.but.not.a="echo git log branch1..branch2"
alias git.log.show.orphaned.commits.too="git log --reflog"
alias git.log.show.orphaned.commits.too.2="git reflog"
alias git.log.show.just.commit.hashes="git log --pretty=format:'%h'"
alias git.push.force.dry.run="git push --dry-run -f origin"
alias git.reflog.show.filenames="git reflog --stat"
alias git.remote.set.origin.different.url="echo 'add the git://new.url.here to the command'; git remote set-url origin"
alias git.rev-parse.show.toplevel.repo.dir="git rev-parse --show-toplevel"
alias git.rev-parse.show.commit.hash.for.HEAD="git rev-parse HEAD"
alias git.rev-parse.show.commit.hash..for.HEAD.short="git rev-parse --short HEAD"
alias git.rm.untracked.files="git clean -f"
alias git.rm.untracked.directories="git clean -df"
alias git.show.commit.hash.for.HEAD.2="git show --no-patch --format=%H; git show --no-patch --format=%h"
alias git.show.describe.first.tag.reachable.from.HEAD="git describe"
alias git.reset.unstage.all.files="git reset HEAD -- ."  # or git reset FILE
alias git.stash.show.diff="git stash show -p"
alias git.undo.rm.modified.and.staged.files="git reset --hard"
alias git.vimdiff="git difftool --no-prompt --tool=vimdiff"
alias git.vim.cached.staged='vim $(git diff --name-only --cached)'
alias git.vim.conflicts='vim $(git diff --name-only --diff-filter=U)'
alias git.vim.modified.and.new='vim $(git.ls.filenames.modified) $(git.ls.filenames.new.untracked)'
#alias git.diff.old="(git difftool  --ignore-submodules=dirty --extcmd=diff --no-prompt $*)"

alias help.find.delete='echo find . -name "*.pyc" -delete'

if $MacOSX; then
    alias ls="ls -G"
    # Commented-out Wed 3/5/14 4:20pm after upgrade to Mavericks.
    # I cannot get mvim working with command-t on Mavericks.
    #alias vim='mvim -v'
    alias iphone.simulator="/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/Applications/iPhone\ Simulator.app/Contents/MacOS/iPhone\ Simulator"
else
    alias ls="ls -CF --color"
    alias gvim="  /cygdrive/c/Program\ Files\ \(x86\)/Vim/vim72/gvim.exe"
    alias gvimdiff="c:/WINDOWS/gvimdiff.bat"
fi

alias idle='env python3 /usr/lib/python3.2/idlelib/idle.py &'
alias ipaddr='ipconfig getifaddr en0'
alias ipaddr-2='ifconfig | grep inet'

alias l=ls
alias lh=lshead
alias ll="ls -ltr"
alias lsless="ls -lt|less"
alias lsx="ls -l | grep '^-..x'"
alias lib="title library; telnet multnomah.lib.or.us"
alias lt="ls -lt | less"

alias macos-clear-dns-cache="sudo killall -v -HUP mDNSResponder"
alias macos-clear-dns-cache-show="sudo killall -v -d mDNSResponder"  # -d ==> print info, don't send signal
alias macos-reboot-wifi="(set -x; ifconfig en0; sudo ifconfig en0 down; sudo ifconfig en0 up; sleep 2; ifconfig en0)"
alias mv="mv -i"
alias mycmd_old_pre_v1.7_django_versions='(set -x; rm -f mydb.db db.sqlite3;./manage.py syncdb --noinput; ./manage.py mycmd)'
alias mycmd='(set -x; rm -rf mydb.db db.sqlite3 myapp/migrations;./manage.py makemigrations; ./manage.py migrate; ./manage.py mycmd)'
alias mycmd.nosync='(set -x; ./manage.py mycmd)'

alias nettop.monitor.network.traffic.bandwidth="nettop"

alias open.postgresql.manual="open $DirDropbox/Rob/postgresql-9.4-US-entire-manual-dated-Feb-20-2015.pdf"
alias open.resume="open $DirResume/*pdf"
alias open.solr.manual="open $DirDropbox/Rob/apache-solr-ref-guide-4.10-downloaded-Feb-20-2015.pdf"
alias open.sqlalchemy.manual="open $DirDropbox/Rob/sqlalchemy-0.9.8-downloaded-Feb-20-2015.pdf"
alias open.sqlalchemy.manual.adobe.reader="open.adobe.reader $DirDropbox/Rob/sqlalchemy-0.9.8-downloaded-Feb-20-2015.pdf"
alias open.the.effective.engineer="open $DirDropbox/Rob/the-effective-engineer-sample.pdf"

if $MacOSX; then
alias osx.wifi.reboot="networksetup -setairportpower en1 off; networksetup -setairportpower en1 on"
fi

alias pgoog="ping google.com"
alias pok="title poughkeepsie sanfs00; telnet 9.12.20.42; ssh rbednark@9.12.20.42"
alias pw3="ping w3.ibm.com"
DirPyWin2="c:/Python27"
DirPyWin3="c:/Python32"
DirPy2="c:/Python27"
DirPy3="c:/Python32"
alias pydocwin2="$DirPyWin2/python.exe $DirPyWin2/Lib/pydoc.py"
alias pydocwin3="$DirPyWin3/python.exe $DirPyWin3/Lib/pydoc.py"
alias pythonwin="$DirPyWin2/python.exe"
alias py2="$DirPy2/python.exe"
alias py2w="$DirPy2/pythonw.exe"
alias py=py2
alias py3="$DirPy3/python.exe"
alias py3w="$DirPy3/pythonw.exe"
alias pywin=pythonwin
alias pipwin="$DirPyWin2/Scripts/pip.exe"

alias quote="echo '================================================================================'; $BinQuote --cfg $DirSync/quote.cfg --linelength 160 $FileQuotes; echo '================================================================================'"
alias quoteOld="echo '================================================================================'; $BinQuote --old --cfg $DirSync/quote.cfg --linelength 160 $FileQuotes; echo '================================================================================'"

alias rm="rm -i"
alias rm.pyc.files="(set -x; find . -name '*.pyc' -delete; set +x)"

alias scp.nginx.logs="scp -Cpr -i $PemTixie515 ubuntu@$MachineProdWeb:/var/log/nginx ."
alias screensaver="gnome-screensaver-command --activate"
alias script_date="script ~rbednark/logs/typescript.`date +%Y.%m.%d.%H.%M.%S.%a`"
alias script_date2='script ~rbednark/logs/typescript.`date +%Y.%m.%d.%H.%M.%S.%a`'
#alias seleniumServerRun="java -jar C:/cygwin/home/sara/selenium/selenium-server-1.0.3/selenium-server.jar"
alias seleniumServerRun="title Selenium Server; java -jar C:/cygwin/home/sara/selenium-2.0b1/selenium-server-standalone-2.0b1.jar"
#alias sshmtproxy="echo mtd@t@2011; ssh root@mtproxy.futurewei.ebento.net"
#alias sshmtproxy8="echo wloe...; ssh rbednark@mtproxy8.ebento.net"
#alias sshtest="title douglas; ssh rbednark@$hostDouglas"
alias ssh="ssh -A"
alias ssh.rob-aws="ssh -i $PemRobKey ubuntu@$MachineRobAWS"

alias source.django="source $DirDropbox/bin/learn/dir.learn.django.projects/source.venv"
alias sourcetree="open -a SourceTree"
alias sourcetree.this.repo='sourcetree "$(git rev-parse --show-toplevel)"'
alias subl2="/Applications/Sublime\ Text\ 2.app/Contents/SharedSupport/bin/subl"
alias subl3="/Applications/Sublime\ Text\ 3.app/Contents/SharedSupport/bin/subl"
alias subln="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"
alias subl=subln

alias tail.downtime="tail -999f $FilePingSymlinkActive | grep time.DOWN"
alias tail.summary="tail -99f $FilePingSymlinkActive | grep SUMMARY"
alias ping.tail.time="tail -5 $FilePingSymlinkActive; tail -99f $FilePingSymlinkActive | grep SUMMARY:.time"
alias ping.tail.down="tail -5 $FilePingSymlinkActive; tail -9999f $FilePingSymlinkActive | grep 'SUMMARY: time DOWN:'"
alias ping.tail="tail -20f $FilePingSymlinkActive"
alias ti=title
alias tlab="title svc driver; telnet $MachineSvcDriver"
alias tbvt3="telnet $MachineBvt3Driver9"
alias telm35="telnet $elm35"
alias telm36="telnet $elm36"
alias telm37="telnet $elm37"
alias telm50="telnet $elm50"
alias tritu="telnet $MachineRitu"
alias trob="ssh -l root $MachineRob"
alias ssvcdriver="title SVC Driver; ssh root@$MachineSvcDriver"
alias tsvcdriver="title SVC Driver; telnet $MachineSvcDriver"
alias taix="telnet 192.168.40.25"

if $MacOSX; then
    alias top="top -c d -o cpu -s 2"
fi

alias v=vim
alias vaddrs="title vi email addresses; vici $FileEmailAddrs"
alias vagrant.halt='cdvagrant; vagrant status; time vagrant halt; vagrant status'
alias vagrant.ssh='cdvagrant; vagrant status; date; time vagrant up; date; vagrant ssh'
alias vagrant.status='cdvagrant; vagrant status'
alias vask="cd $DirQuiz; vici db_*ask*stackoverflow"
alias vconvert="title teamroom.how.to.convert.to.flexsan.html; cd $DirDoc; explorer.exe teamroom.how.to.convert.to.flexsan.html; vici teamroom.how.to.convert.to.flexsan.html"
alias vebento="cdsel; vici ebento.py"
alias vhw="title Huawei; vici $FileToDo $FileHuawei $FileJ $FileDoc"
alias vgoserver="title teamroom.design.proposal.eliminating.GoServer.html; cd $DirDoc; explorer.exe teamroom.design.proposal.eliminating.GoServer.html; vici teamroom.design.proposal.eliminating.GoServer.html"
alias vgtest="title gtest.html; cd $DirDoc; (firefox file:///`type cygpath > /dev/null 2>&1 && cygpath -m $DirDoc/teamroom.brownbag.gtest.html` &); vici teamroom.brownbag.gtest.html"

alias vhowtorun="vici $DirDoc/teamroom.how.to.run.html"
alias vninja="title ninja.html; cd $DirDoc; (firefox file:///`type cygpath > /dev/null 2>&1 && cygpath -m $DirDoc/ninja.html` &); vici ninja.html"
alias vobs="title readme.obs.html; cd $DirDoc; explorer.exe readme.obs.html; vici readme.obs.html"
alias vi=vim

alias vdone="vici $FileAccomplishments"
alias vj.other="vici $FileJTmp $FileToDo $FileDiary $FileHuawei"
alias vj="title j; vici $FileJ ; echo vici $FileJTmp $FileToDo $FileDiary $FileHuawei"
alias vjtmp="title interim j; vici $FileJTmp"
alias vjtmp.read.only="title j; vim -R $FileJ $FileJTmp $FileToDo $FileDiary $FileHuawei"
alias vl='vim -c "normal '\''0"'  # vim the last file that was edited in vim; '0 means the most recent file; "-c" means execute this command; I think "normal" means start in normal mode, but I'm not sure
alias vlyrics="title lyrics; vici $DirDoc/lyrics.txt"
alias vmeetups="cd $DirQuiz; vici *meetups"
alias vone="vici $DirDoc/teamroom.one.button.html"
alias vphone="title vphone; vici $FilePhone"
alias vpicts="vici $FilePicts"

# files very active with for a limited duration
alias vatd="cd $DirLearn; vici atd_survey_filter.py"

# Quiz files
alias vabraham.hicks.quotes="vici $DirQuiz/abraham-hicks.quotes"
#alias vachievements.atlatl="title vachievements.atlatl; vici $DirQuiz/achievements.atlatl"
alias vapps="title vapps; cd $DirQuiz; vici db_apps"
alias varchitecture="vici $DirQuiz/db_software_design_architecture"
alias vatlatl="title vatlatl; vici $DirQuiz/db_atlatl"
alias vcoverletters="title cover.letters; vici $DirQuiz/job_cover_letters_applications.txt"
alias vdaily="title vdaily; cd $DirQuiz; vici db_daily_review"
alias vdiary="title vdiary; cd $DirQuiz; vici db_diary"
alias vdjango="title vdjango; cd $DirQuiz; vici db_django"
alias vfamily="cdfam; vim -R docs.July.1.Fri/r*txt gedcoms-from-ancestry.com/*.ged"
alias vfun="cd $DirQuiz; vici db_fun"
alias vgit="title vgit; cd $DirQuiz; vici db_git"
alias vgratitude="cd $DirQuiz; vici gratitude"
alias videalist="cd $DirQuiz; vici idealist"
alias vinterview="cd $DirQuiz; vici db_interview_questions_master_template"
alias viphone="title viphone; cd $DirQuiz; vici *iphone*"
alias vjavascript="cd $DirQuiz; title db_javascript; vici db_javascript"
alias vjobsearch2016="vici $DirQuiz/job_search_Sep_2016"
alias vjobsearch="vici $DirQuiz/cover_letters* $DirQuiz/job_search_Sep_2016 $DirQuiz/portland.job.scene $DirQuiz/job.search.Aug.2015 $DirQuiz/db_resume $DirDoc/cover.letters.txt $DirDoc/job.openings.descriptions.txt $DirQuiz/job.descriptions $DirQuiz/job.references"
alias vjournaling="cd $DirQuiz; vici db_journaling"
alias vjs="vici $DirLearn/javascript/learn_javascript_lang_elements.js"
alias vlearn="cd $DirQuiz; vici db_learn"
alias vlos_angeles="vici $DirQuiz/db_los_angeles"
alias vm="vici $DirMoovel/moovel.txt"
alias vmac="title vmac; cd $DirQuiz; vici db_mac"
alias vmaster.manifest="title vmaster.manifest; cd $DirQuiz; vici master.manifest.txt"
alias vmisc="cd $DirQuiz; vici db_misc"
alias vsens-moovel="vici $DirMoovel/moovel-sens.txt"
alias vpaste="vici ~/tmp/paste"
alias vpeople.quiz="vici $DirQuiz/db_quiz_people"
alias vprogramming="cd $DirQuiz; vici db_programming"
alias vpython="title vpython; cd $DirQuiz; vici db_python"
alias vquiz="cd $DirQuiz; vici *xie *nix *apps *thon *ogy"
alias vquizme="cd $DirQuizMe; vici README"
alias vq="git.commit.all.modified.and.new.for.repo.of.given.file $DirAddToQuizme/learn_add_to_quizme; vim $DirAddToQuizme/learn_add_to_quizme  $DirQuizMe/db_dumps/latest.dump.txt; git.commit.all.modified.and.new.for.repo.of.given.file $DirAddToQuizme/learn_add_to_quizme"
alias vquizmedb-second-file="vim  $DirQuizMe/db_dumps/latest.dump.txt"
alias vresume=vjobsearch
alias vresume.word="open -a 'Microsoft Word' $DirDropbox/Documents/Rob.Bednark.resume.docx"
#alias vresume.pdf="open -a "Microsoft Word"'
alias vselenium="vici $DirQuiz/db_selenium"
alias vtalks="vici $DirQuiz/db_talks"
alias vsql="title vsql; cd $DirQuiz; vici db_sql"
alias vstudy="title vstudy; cd $DirQuiz; vici db_study_notes_journal_diary"
alias vsurvey="title vsurvey; cd $DirQuiz; vici db_mike_ames_surveygizmo"
alias vtrapit="title vtrapit; cd $DirQuiz; vici db_trapit"
alias vunix="title vunix; cd $DirQuiz; vici db_unix"
alias vvim="title vvim; cd $DirQuiz; vici db_vim"
alias vtixie="title vtixie; cd $DirQuiz; vici $FileQuizTixie $FileNotesTixie"
alias vtixieconfidential="title vtixie; vici $DirQuiz/db_tixie_confidential"
alias vweb="title vweb; cd $DirQuiz; vici *web*"
alias vrc="title vrc; (cd `dirname $FileRc`; vici `basename $FileRc`); dotrc"
alias vrecipes="vici $DirDoc/fvt.team.recipes.txt"
alias vrequirements="vici $DirDoc/teamroom.fvt.requirements.html"
alias v.six.degrees="vici $DirQuiz/db_six_degrees_of_connection"
alias vspinosa="vici $DirDoc/spinosa.property.values.txt"
alias vstocks="vici  $DirQuiz/db_stocks_options $FileStocks $FileStockNotes"
alias vpsych="vici $FileMyPsychology"
alias vtoday="title vtoday; vici  $FileAccomplishments $FileDoc"
alias vtower="title vtower; vici $DirDoc/tower.hill.property.values.txt"
alias vtodo="title ToDo; vici  $FileLearnTodo $FileTodayNew $FileToday"
alias vlists="title vlists; rm -f /tmp/tmp.todo*; /home/rbednark/bin/todo.py --makeLists; vim  /tmp/tmp.todo*"
alias vtips="title tips.html; (firefox file:///`type cygpath > /dev/null 2>&1 && cygpath -m $DirDoc/tips.html` &); vici $DirDoc/tips.html"
alias vvimrc="cd `dirname $FileVimrc`; vici `basename $FileVimrc`"
alias vxd="cd $DirUnixConfigFiles; vici .Xdefaults"
alias winmerge="'/cygdrive/c/Program Files/WinMerge/WinMerge.exe'"

################################################################################
### Functions
################################################################################

function aws.instance.info() {
    # Show the instance info for the AWS you are logged-in to.
    AWS_PUBLIC_HOSTNAME=$(curl --silent http://169.254.169.254/latest/meta-data/public-hostname)
    AWS_LOCAL_HOSTNAME=$(curl --silent http://169.254.169.254/latest/meta-data/local-hostname)
    AWS_HOSTNAME=$(curl --silent http://169.254.169.254/latest/meta-data/hostname)
    AWS_AMI_ID=$(curl --silent http://169.254.169.254/latest/meta-data/ami-id)
    AWS_INSTANCE_TYPE=$(curl --silent http://169.254.169.254/latest/meta-data/instance-type/)
    AWS_PUBLIC_KEYS=$(curl --silent http://169.254.169.254/latest/meta-data/public-keys/)
    set | grep '^AWS_' | sort
}

function check.cmd.before.tests() {
    for oneFile in `\ls -1`; do
        echo "+ grep $oneFile cmd.before.tests"
        grep $oneFile cmd.before.tests
        rc="$?"
        if [ $rc -eq 0 ]; then
            echo "YES: $oneFile"
        else
            echo "NO : $oneFile"
        fi
    done
}

function cilm () {
    DirBase=`dirname $1`
    mkdir -p $DirBase/RCS
    ci -zLT -t-. -l -m. $*
}
function cd.package.dir() {
    # cd to the directory that contains the specified python package
    _py_package=$1
    _py_file=$(python -c "import ${_py_package}; print(${_py_package}.__file__)")
    cd $(dirname ${_py_file})
}
function show.ansi.escape.sequences.color.grid( ) {
    iter=16
    while [ $iter -lt 52 ]
    do
        second=$[$iter+36]
        third=$[$second+36]
        four=$[$third+36]
        five=$[$four+36]
        six=$[$five+36]
        seven=$[$six+36]
        if [ $seven -gt 250 ];then seven=$[$seven-251]; fi

        echo -en "\033[38;5;$(echo $iter)m█ "
        printf "%03d" $iter
        echo -en "   \033[38;5;$(echo $second)m█ "
        printf "%03d" $second
        echo -en "   \033[38;5;$(echo $third)m█ "
        printf "%03d" $third
        echo -en "   \033[38;5;$(echo $four)m█ "
        printf "%03d" $four
        echo -en "   \033[38;5;$(echo $five)m█ "
        printf "%03d" $five
        echo -en "   \033[38;5;$(echo $six)m█ "
        printf "%03d" $six
        echo -en "   \033[38;5;$(echo $seven)m█ "
        printf "%03d" $seven

        iter=$[$iter+1]
        printf '\r\n'
    done
}
function dc-rebuild-container() {
    container=$1
    (set -x;
     docker-compose stop $container;
     docker-compose rm --force $container;
     docker-compose build $container;
     docker-compose create $container;
     docker-compose start $container;
    )
}
function dc-restart-tail-logs() {
    services=$@
    set -x
    docker-compose restart ${services}
    docker-compose logs --timestamps --follow --tail=50 ${services}
    set +x
}
function docker-rm-everything() {
    (set -x;
     docker stop $(docker ps --all --quiet) # stop all running containers
     docker rm $(docker ps --all --quiet) # remove all containers
     docker rmi --force $(docker images --all --quiet) # remove all images
     docker volume rm $(docker volume ls --quiet) # remove all volumes
     docker ps --all
     docker volume ls
     docker images --all
    )
}
function emailaddr () {
  grep -i $@ $FileEmailAddrs
}
function find.portal () {
     find .|xargs grep $@ /dev/null
}
function vifind.portal() {
     files=`find .|xargs grep -l $@ /dev/null`
     vim -R $files
}

function git.branch.show() {  
    # Just show the current branch name
    git rev-parse --abbrev-ref HEAD 2> /dev/null
}
function gitall() { 
    # run the specified git command on all subdirectories
    for dir in *; do 
        echo "================================================================================"
        echo $dir
        echo "================================================================================"
        cd $dir
        git $*
        cd ..
    done
}
function git.files.changed.in.commit () {
  # git.files.changed.in.commit <treeish>
  # Show the files that were changed in a given commit.
  # e.g., git.files.changed.in.commit HEAD
  # --no-commit-id => don't show the commit ID
  # --name-only    => show only file names, not owner, group, perms
  # -r             => recurse into sub-trees
  git diff-tree --no-commit-id --name-only -r $*
}

function git.files.added.and.changed.in.commit () {
  # --no-commit-id => don't show the commit ID
  # --name-only    => show only file names, not owner, group, perms
  # -r             => recurse into sub-trees
  (set -x; git ls-tree --name-only -r $*)
}

function git.fixup.autosquash () {
    # This depends on files already staged
    (
     set -x

     git status

     : Hit return to continue
     read _continue

     git stash --keep-index

     : Hit return to continue
     read _continue

     git status
     git diff --cached

     : Hit return to continue
     read _continue

     git commit --fixup HEAD
     : Hit return to continue
     read _continue

     git rebase -i --autosquash HEAD~2

     : Hit return to continue
     read _continue

     git stash pop
     git status
    )
}
function git.diff.old () {
  (set -x; git difftool  --ignore-submodules=dirty --extcmd=diff --no-prompt $*)
}

function grc() {
    grep -i $@ $FileRc
}
function pless() {
    # pipe stdout/stderr to less
    $@ 2>&1 | less
}
function latest() {
    _file=$(ls -1t $@ | head -1)
    if [ "$@" != "" ]; then
        _dir="$@" 
        echo "$_dir/$_file"
    else
        echo $_file
    fi
}
function ln_node_modules() {
    # ${PWD##*/} ==> get the name of the current directory
    _target=$DirNodeModulesLocal/$(basename $(pwd))
    mv node_modules $_target
    ln -s $_target node_modules
}
function moovel-reclone-gamma-docker() {
    (set -x;
     date; 
     cddocker; 
     bin/status.sh;
     read -p "Hit return to continue... ";
     cd ..; 
     rm -fr gamma-docker-4 && git clone git@github.com:moovel/gamma-docker.git gamma-docker-4 && cd gamma-docker-4 && bin/rebuild.sh;
     date
    )
}
function npm-exec () {
    # Run a command that is an executable
    # "npm bin" => returns the directory of the executables (e.g., node_modules/.bin)
    (PATH=$(npm bin):$PATH; eval $@;)
}
function phone () {
  grep -i $@ $FilePhone
}
function ping.monitor() {
    title ping.monitor
    python -u $DirDropbox/bin/learn/log_track_monitor_online_wifi_status_with_ping.py >> $FilePingOutput 2>&1 &
    rm -f $FilePingSymlinkActive
    ln -s $FilePingOutput $FilePingSymlinkActive
    sleep 3;
    ping.tail.time
}
function rcs.show.lock() {
    for oneFile in $@; do
        #echo "File: $oneFile"
        echo -n "locks:  (your userid = [$(whoami)])"
        rlog $oneFile | grep --after-context=1 'locks:' | grep -v locks:
    done
}
function rcs.unlock.lock() {
    for oneFile in $@; do
        echo "File: $oneFile"
        rcs.show.lock $oneFile
        rcs -u -M $oneFile
        rcs -l -q $oneFile
        rcs.show.lock $oneFile
    done
}

function scp.sync() {
    allFiles=""
    for oneFile in $@
    do
        allFiles="$allFiles $DirDriverSync/$oneFile"
    done
    set -x
    scp -p $allFiles .
    set +x
}

function subl.django() {
    dir_django=$(python -c "import django,os; print os.path.dirname(django.__file__)")
    subl $dir_django
}

function title_linux {
    echo -ne "\e]2;$*\a"
}

function title_set {
    # iTerm2  - set the name of the tab, the window, or both
    # https://hacksformacs.wordpress.com/2015/08/20/setting-iterm2-tab-and-window-titles/
    _mode=$1; shift  # 0=both  1=tab  2=window
    _title="$@"
    echo -ne "\033]${_mode};"${_title}"\007"
}

title.both()   { title_set 0 $@; }
title()        { title_set 1 $@; }
title.tab()    { title_set 1 $@; }  # Note that title.tab set just the tab only if you've already set just the window
title.window() { title_set 2 $@; }


function titlessh {
    ssh $Rob ~/bin/title $@
}
### Note: this function must be defined after the "alias cilm", otherwise cilm is not resolved in this function.
function rcsdiff_files_differ {
    rcsdiff $@ > /dev/null 2>&1
    return $?
}
function rcsdiff_show_files_that_diff {
    for one_file in $@; do
        if [ ! -d $one_file ] && ! rcsdiff_files_differ $one_file; then
            echo $one_file
            #rcs.show.lock $one_file
        fi
    done
}
function git.commit.all.modified.and.new.for.repo.of.given.file() {
    onefile=$1
    title $(basename $onefile)
    DirCurDir=$(pwd)
    DirBase=`dirname $onefile`

    # Go to the top level of the repo to add all files that haven't been added
    cd $DirBase
    pwd
    DirGit=$(git rev-parse --show-toplevel)
    cd "$DirGit"
    pwd

    # Show status
    echo "================================================================================"
    git.diff.old
    echo "================================================================================"
    # git --no-pager status --ignore-submodules=dirty

    # Add all files that aren't already in the repo
    # echo "+ git add -A"
    git add -A

    # Commit
    # echo "git commit -a -m 'Auto commit from vici'"
    git commit -a -m 'Auto commit from vici'

    echo "================================================================================"
    git.diff.old
    echo "================================================================================"
    # git --no-pager status --ignore-submodules=dirty
    # Now cd back to the directory where the user was to begin with.
    cd $DirCurDir
    # echo "Hit return to continue (after commit, before vim; onefile=$onefile)..."; read x
}
function vici () { 
    # Use git instead of rcs
    # capture the current dir and return to it after we are done

    if echo $SHELL | grep zsh > /dev/null; then
        # setopt shwordsplit causes zsh to behave like bash for splitting a string (e.g., $files)
        setopt shwordsplit
    fi

    # ISSUE: 4/18/14: vici does not work for multiple files; why not?
    #   o 4/18 7:42am I removed the quotes from files=$@ -- result: no difference; still has space in filename
    cur_dir=$(pwd)
    files=$@
    # Would be best to get a list of the repositories for all the files, and only do one commit
    # for each repository.  For now, just do it for each.
    # echo "DEBUG: files=[$files]"
    # echo "DEBUG: \$#=[$#]"
    for onefile in $files; do
        # echo "DEBUG: onefile=[$onefile]"
        git.commit.all.modified.and.new.for.repo.of.given.file $onefile
    done
    # echo "Hit return to [vim $files]..."; read FOO
    vim $files
    for onefile in $files; do
        # echo "Hit return to [git.commit.all.modified.and.new.for.repo.of.given.file $onefile]..."; read FOO
        git.commit.all.modified.and.new.for.repo.of.given.file $onefile
    done

    # cd back to the directory we were in before we started
    cd $cur_dir
}
function vici.old () {
    DirBase=`dirname $1`
    # Create the RCS dir if it doesn't exist
    mkdir -p $DirBase/RCS
    files="$@"

    rcsdiff $files
    echo "==================================================================="
    # checkin all the files before editing them
    cilm $files
    if ! rcsdiff_files_differ $files; then
            # Assert: the files are different, even after attempting to check them all in
            for oneFile in $files; do
                if [ -e $oneFile ] && rcsdiff_files_differ $oneFile; then 
                    # ASSERT: the file exists, and it differs from the RCS version
                    rcs.show.lock $oneFile
                    echo "ERROR: file [$oneFile] cannot be checked-in.  Want to rcs.unlock.lock? [y/N]"
                    read resp
                    if [ "$resp" = "y" ]; then
                        echo "You said yes [$resp].  Unlocking and cilm"
                        rcs.unlock.lock $oneFile
                        rcsdiff $oneFile
                        cilm $oneFile
                        rcs.show.lock $oneFile
                        echo "Hit return to continue..."; read foo
                    else
                        echo "you said NO [$resp]"
                    fi
                elif [ ! -e $oneFile ] && [ -e RCS/$oneFile,v ]; then
                    echo "WARNING: [$oneFile] does not exist but [RCS/$oneFile,v] does exist."
                    echo "Hit return to continue..."; read foo
                else
                    # either the file is not different from the RCS version,
                    # or else this is a new file that has not yet been created and saved.
                    :
                fi
                set +xv
            done
    fi
    echo "Hit return to continue..."; read x
    # Edit the files
    vim $files
    # Show the diffs
    rcsdiff $files
    echo "==================================================================="
    # Checkin the files again
    cilm $files
}
function vabout() { 
    title aboutMe
    cd $DirBednarkCom
    (firefox file:///`cygpath -m $FileAbout` &)
    vici $FileAbout $FileIndex
}

function vblog() { 
    title blog
    cd $DirBednarkCom
    (firefox file:///`cygpath -m $FileBlogHtml` &)
    vici $FileBlogHtml $FileIndex $FileBlog $FileSiteMapXml
    upload.to.bednark.com $FileBlogHtml $FileIndex
}

function vbooknotes() { 
    title bookNotes
    cd $DirBednarkCom
    (firefox file:///`cygpath -m $FileBooknotes` &)
    vici $FileBooknotes $FileIndex
    upload.to.bednark.com $FileBooknotes $FileIndex
}

function vemailgroups() { 
    title email.groups.html
    cd $DirBednarkCom
    (firefox file:///`cygpath -m $FileEmailGroups` &)
    vici $FileEmailGroups $FileIndex
    upload.to.bednark.com $FileEmailGroups $FileIndex
}

function vcontact() { 
    title bednark.com contact.info.cpp
    cd $DirBednarkCom
    (firefox file:///`cygpath -m $FileContactInfo` &)
    vici $FileContactInfo
    upload.to.bednark.com $FileContactInfo
}
function vindex() { 
    title bednark.com index.cpp
    cd $DirBednarkCom
    (firefox file:///`cygpath -m $FileIndex` &)
    vici $FileIndex
    upload.to.bednark.com $FileIndex
}

function vpeople() { 
    title people.I.know
    cd $DirBednarkCom
    if $MacOSX; then
        # open $FilePeopleHtml http://bednark.com/people.I.know.html
        :
    else
        (firefox file:///`cygpath -m $FilePeopleHtml` &)
    fi
    vici $DirQuiz/*people $FilePeopleHtml $FileInformixEmployees $FilePeopleTxt $FileIndex $DirFamilyTreeReports/*txt
    # upload.to.bednark.com $FilePeopleHtml $FileBlogHtml $FileIndex
}

function vhumor() { 
    title humor
    cd $DirBednarkCom
    if $MacOSX; then
        open -a Google\ Chrome $FileHumor
    else
        (firefox file:///`cygpath -m $FileHumor` &)
    fi
    vici $FileHumor $FileIndex
    upload.to.bednark.com $FileHumor $FileIndex
}
function vquotes() { 
    title quotes
    cd $DirRepoRobBednarkGithubIO
    if $MacOSX; then
        open file:///$FileQuotes $URL_robbednark_github_io/quotes.html
    else
        (firefox file:///`cygpath -m $FileQuotes` http://bednark.com/quotes.html &)
    fi
    vici $FileQuotes $FileIndex $FileSitemap
    git push
}
function vrecommendations() { 
    title recommendations
    cd $DirBednarkCom
    (firefox file:///`cygpath -m $FileRecommendations` &)
    vici $FileRecommendations $FileIndex
    upload.to.bednark.com $FileRecommendations $FileIndex
}

function vsitemap() { 
    title site.map.cpp
    cd $DirBednarkCom
    (firefox file:///`cygpath -m $FileSiteMapHtml` &)
    vici $FileSiteMapHtml 
    upload.to.bednark.com $FileSiteMapHtml
}
function vsoftwarequotes() { 
    title software.quotes
    cd $DirBednarkCom
    (firefox file:///`cygpath -m $FileSoftwareQuotes` &)
    vici $FileSoftwareQuotes $FileIndex
    upload.to.bednark.com $FileSoftwareQuotes $FileIndex
}
function vstories() { 
    title stories
    cd $DirBednarkCom
    (firefox file:///`cygpath -m $FileStories` &)
    vici $FileStories $FileIndex
    upload.to.bednark.com $FileStories $FileIndex
}
function vstrings() { 
    title violin strings survey
    cd $DirBednarkCom
    (firefox file:///`cygpath -m $FileViolinStrings` &)
    vici $FileViolinStrings $FileIndex
    upload.to.bednark.com $FileViolinStrings $FileIndex
}
function vvocab() { 
    title vocab
    cd $DirQuiz
    cd $DirBednarkCom
    (firefox file:///`cygpath -m $FileVocab` &)
    vici $DirQuiz/db_vocab $FileVocab $FileIndex
    upload.to.bednark.com $FileVocab $FileIndex
}


function getbednark.com() {
    rm -fr /tmp/bednark.com
    mkdir -p /tmp/bednark.com
    scp -p 'rob@bednark.com:/home/rob/bednark.com/docs/*html' /tmp/bednark.com
}
function upload.defaults.to.bednark.com() {
    upload.to.bednark.com $FileIndex $FileQuotes $FileAbout $FileBooknotes
}
function upload.to.bednark.com() {
    set -xv
    cd $DirBednarkCom
    scp -pr $@ 'rob@bednark.com:/home/rob/bednark.com'
    set +xv
}
function web() {
    action=$1
    (set -x;
     sudo service apache2 $action;
     sudo service nginx $action;
    )
}
function pgconfigs() {
    DirPostgres=/etc/postgresql/*/*
    vim $DirPostgres/pg_hba.conf $DirPostgres/postgresql.conf
}
function pglogs() {
    DirPostgres=/var/log/postgresql
    vim $DirPostgres/*
}
function webconfigs() {
    DirApache=/etc/apache2
    DirNginx=/etc/nginx
    DirPostgres=/etc/postgresql/*/*
    vim $DirApache/sites-enabled/* $DirApache/*.conf $DirNginx/*conf $DirNginx/sites-enabled/* $DirNginx/*params $DirPostgres/pg_hba.conf $DirPostgres/postgresql.conf
}
function weblogs() {
    DirApache=/var/log/apache2
    DirNginx=/var/log/nginx
    DirPostgres=/var/log/postgresql
    vim $DirNginx/error*log $DirNginx/access*log $DirApache/error*log $DirApache/other*log $DirPostgres/*
}

################################################################################
### Set's
################################################################################
### Set the command-line editing mode to "vi" (rather than the default of emacs)
set -o vi

################################################################################
# Other functions
################################################################################
function cpp.bednark.com() {
    cd $DirBednarkCom/cpp
    #tmpDirCppOutput="$DirBednarkCom/cpp.output"
    #mkdir -p $tmpDirCppOutput

    if [ $# -ge 1 ]; then
        allFiles="$*"
    else
        allFiles="*"
    fi;

    for oneFile in $allFiles; do
        # e.g., input: foo.cpp  output: foo.html
        fileOutput=`echo $oneFile | sed -e 's/cpp/html/g'`
        # cpp.include.file.py is a file that I wrote
        echo "Processing file [$oneFile]..."
        cpp.include.files.py $oneFile >  ../$fileOutput
    done
}
function firefoxfile() {
    title firefox $1
    echo "NOTE: this firefoxfile function only works for relative paths, not for absolute paths"
    set -x
    if echo $1 | grep '^/' > /dev/null 2>&1; then
        # This is an absolute path, because it starts with a "/"
        pathWin=`cygpath -m "$1"`
    else
        # This is a relative path, because it does not start with a "/"
        pwdNow=`pwd`
        pathWin=`cygpath -m "$pwdNow/$1"`
    fi
    echo $pathWin
    (firefox file:///"$pathWin" &)
    set +x
}
function ls.1.less() {
    echo 'e.g., ls.1.less foo (ls -1d *foo* | less)' > /dev/null
    ls -1d *$1* | less
}
function ls.newest.files() {
    echo "e.g., ls.newest.files 5 (shows the newest 5 files)" > /dev/null
    # Need to quote the filenames, in case they have spaces in them, like the chat logs do.
    number=${1:-20}
    files=`find * -type f -prune | xargs \ls -1dt | head -${number}`
    ls -ltrd $files
}
function python.module.dir() {
    python $DirLearn/get_module_path.py $*
}
function vim.git.grep() {
    vim $(git grep -l $*)
}
function vim.ls.head() {
    echo "e.g., vim.ls.head (edits the newest 5 files)" > /dev/null
    # Need to quote the filenames, in case they have spaces in them, like the chat logs do.
    number=5
    files=`find * -type f -prune | xargs \ls -1dt | head -${number}`
    vim $files
}
function vim.last.n.files() {
    echo "e.g., vim.last.n.files '*report' 10" > /dev/null
    pattern=$1
    number=$2
    # Need to quote the filenames, in case they have spaces in them, like the chat logs do.
    vim `ls -1t $pattern | head -$number`
    #files=""
    #for oneFile in `ls -1t $pattern | head -$number`; do
        #files="$files \"'\"$oneFile\"'\" " 
    #done
    #vi -R $files
}
function vim.files.with.pattern() {
    echo "e.g., vim.files.with.pattern 'FAILED' '*.runxml.log*' 10" > /dev/null
    patternGrep=$1
    patternFile=$2
    number=${3:-20}
    files=`\ls -1t $patternFile | xargs --no-run-if-empty grep -iIl "$patternGrep" /dev/null | head -${number}`
    vim -R $files
}
function vici.grep.i() {
    patternGrep=$1
    echo "Pattern=[$patternGrep]"
    files=`grep -iIl $patternGrep *`
    vici $files
}
function vim.grep.l() {
    # USAGE: vim.grep.l {grep_args}
    # vim all files in current dir that contain {grep_args}
    grepArgs="$*"
    echo "grep args=[$grepArgs]"
    if $MacOSX; then
        set -xv
        grep -Il $grepArgs | xargs vim
        set +xv
    else
        set -xv
        grep -Il $grepArgs | xargs --no-run-if-empty vim
        set +xv
    fi
}
function vim.grep.il() {
    # USAGE: vim.grep.il {grep_args}
    # vim all files in current dir that match "grep -i {grep_args}"
    patternGrep=$1
    echo "Pattern=[$patternGrep]"
    set -xv
    if $MacOSX; then
        grep -iIl $patternGrep * | xargs --no-run-if-empty vim
    else
        grep -iIl $patternGrep * | xargs vim
    fi
    set +xv
}
function vim.grep.ril() {
    # USAGE: vim.grep.ril {grep_args}
    # Vim all recursively found files that match "grep -rilI {grep_args}"
    patternGrep=$1
    echo "Pattern=[$patternGrep]"
    grep -rilI $patternGrep . | xargs vim

    # This one will only work with xargs that supports the --no-run-if-empty option:
    #grep -ril $patternGrep . | xargs --no-run-if-empty vim
}
function redirect-and-tail-output() {
    FileTmp=~/tmp/output-$(datestamp)
    ($@) >& ${FileTmp} &
    tail -f $FileTmp
}
function vim.output() {
    FileTmp=~/tmp/output-$(datestamp)
    # This doesn't work yet for a pipeline with grep, 
    # e.g.,
    #     vim.output echo foo | grep foo
    ($@) >& ${FileTmp}
    vim $FileTmp
}
function tail.recent.logs() {
    # Tail the newest 2 log files
    (set -xv; date; tail -30f $(ls -1tr ~/logs | head -n 2) )
}
function tail.newest.n.files() {
    echo "e.g., tail.newest.n.files 2 '*.log' > /dev/null" > /dev/null
    number=${1:-1}
    pattern=${2:-}
    #files=`\ls -1t | xargs --no-run-if-empty find -type d -prune | head -${number}`
    files=`find * -type f -prune | xargs \ls -1d | head -${number}`
    files2=""
    for oneFile in $files; do
        if [ -d $oneFile ]; then
            # skip directories
            :
        else
            files2="$files2 $oneFile"
        fi
    done
    tail -99f $files
}
function hg() {
    # hg = history | grep
    echo "e.g., histgrep foo" > /dev/null
    patternGrep="$1"
    history | egrep -i $patternGrep
}
function hgt() {
    # hgt = history | grep | tail
    echo "e.g., histgrep foo" > /dev/null
    patternGrep="$1"
    history | egrep -i $patternGrep | tail
}
function lsgrep() {
    echo "e.g., lsgrep foo" > /dev/null
    patternGrep="$1"
    ls -ld *"$patternGrep"*
}
function lshead() {
    #number=${1:-30}
    #ls -alt | head -$number
    where=$*
    ls -alt $where | head -10
}
function findExecutables() {
    filesExec=`find * -prune -type f -perm +111`
}
function make.expected.all() {
    set -x
    findExecutables
    ../make.actual.expected $filesExec
    set +x
}
function vexec() {
    findExecutables
    vim $filesExec
}
function run.commands() {
    set -x
    /home/rbednark/bin/commands >> /home/rbednark/output/out.commands.out 2>&1 &
    vim -R /home/rbednark/output/out.commands.out
    set +x
}
function tab() {
  # I got this script from Howard, July 2012, for doing tabs in Mac Terminal.
  TITLE="$1"
  if [ "$1" == "-t" ]
  then
      TITLE="$2"
      shift
      shift
  fi

  osascript 2>/dev/null <<EOF
    tell application "System Events"
      tell process "Terminal" to keystroke "t" using command down
    end
    tell application "Terminal"
      activate
      set frontIndex to index of the first window whose frontmost is true
      tell window frontIndex
        set title displays custom title of selected tab to true
        set custom title of selected tab to "$TITLE"
      end tell
      do script with command "$*" in window 1
    end tell
EOF
}

if hostname | grep -i $HOSTNAME_COMPUTER_MOOVEL > /dev/null; then
    export WORKON_HOME=$HOME/.virtualenvs
    export PROJECT_HOME=$HOME/Devel
    # export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python
    # source /usr/local/bin/pyenv-virtualenvwrapper
    if command -v pyenv 1>/dev/null 2>&1; then
      eval "$(pyenv init -)"
    fi
    # run virtualenvwrapper to get workon, mkvirtualenv, ... functions in my environment
    pyenv virtualenvwrapper
elif ! $Atlatl; then
    # my Retina Mac
    export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python
    [ -f /usr/local/bin/virtualenvwrapper.sh ] && source /usr/local/bin/virtualenvwrapper.sh
    if echo $SHELL | grep zsh > /dev/null; then
        [ -f ~/.git.prompts.zsh ] && source ~/.git.prompts.zsh
    fi
fi

if hash rg 2>/dev/null; then
  # Per https://github.com/aykamko/tag, create an 'rg' alias that
  # gives results and allows you to type something like `e2` to jump to that 
  # result in the editor (vim).
  export TAG_SEARCH_PROG=rg  # replace with rg for ripgrep
  tag() { command tag "$@"; source ${TAG_ALIAS_FILE:-/tmp/tag_aliases} 2>/dev/null; }
  alias rg=tag  # replace with rg for ripgrep
fi

################################################################################
# nosetests autocomplete
# Note: need to "pip install nosecomplete" in the virt as well
################################################################################
if echo $SHELL | grep bash > /dev/null; then
    # bash

    # copied from newer versions of bash
    __ltrim_colon_completions() {
        # If word-to-complete contains a colon,
        # and bash-version < 4,
        # or bash-version >= 4 and COMP_WORDBREAKS contains a colon
        if [[ "$1" == *:* && (
                ${BASH_VERSINFO[0]} -lt 4 ||
                (${BASH_VERSINFO[0]} -ge 4 && "$COMP_WORDBREAKS" == *:*)
            )
        ]]; then
            # Remove colon-word prefix from COMPREPLY items
            local colon_word=${1%${1##*:}}
            local i=${#COMPREPLY[*]}
            while [ $((--i)) -ge 0 ]; do
                COMPREPLY[$i]=${COMPREPLY[$i]#"$colon_word"}
            done
        fi
    } # __ltrim_colon_completions()

    _nosetests()
    {
        cur=${COMP_WORDS[COMP_CWORD]}
        if [[ ${BASH_VERSINFO[0]} -lt 4 ||
              (${BASH_VERSINFO[0]} -ge 4 && "$COMP_WORDBREAKS" == *:*)
        ]]; then
            local i=$COMP_CWORD
            while [ $i -ge 0 ]; do
                [ "${COMP_WORDS[$((i--))]}" == ":" ] && break
            done
            if [ $i -gt 0 ]; then
                cur=$(printf "%s" ${COMP_WORDS[@]:$i})
            fi
        fi
        COMPREPLY=(`nosecomplete ${cur} 2>/dev/null`)
        __ltrim_colon_completions "$cur"
    }
    complete -o nospace -F _nosetests nosetests
fi

if echo $SHELL | grep zsh > /dev/null; then
    # zsh
    autoload -U compinit
    compinit

    autoload -U bashcompinit
    bashcompinit

    _nosetests()
    {
        cur="${COMP_WORDS[COMP_CWORD]}"
        COMPREPLY=(`nosecomplete ${cur} 2>/dev/null`)
    }
    complete -o nospace -F _nosetests nosetests
fi

################################################################################
### end of nosetests completions
################################################################################

# Commented-out the following 2 lines Wed 3/5/14 2:30pm after upgrading to Mavericks, because MacVim (mvim) is giving a SEGV with command-t.
# It looks like this might be because of the Ruby version in my path.
# PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
# [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

######## Generated by Betty's install script
alias betty=/Users/rob/betty/main.rb

if echo $SHELL | grep bash > /dev/null; then
    # autocomplete for git for things like "git checkout my-branchname-some<tab>"
    source ~/.unix.config.files/git-completion.bash
fi
################################################################################
### The end. (.bashrc)
################################################################################

export NVM_DIR="/Users/robb/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
