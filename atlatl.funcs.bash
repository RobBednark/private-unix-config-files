function   atlatl.recreate.db.only() {
    set -x
    find . -name '*.pyc' -delete
    dropdb -U atlatl atlatl
    if createdb -U atlatl atlatl; then
        time ./manage.py syncdb --migrate --no
        return 0
    else
        echo "ERROR from createdb; see above"
        return 1
    fi
}

function   atlatl.recreate.db.only2() {
    set -x
    find . -name '*.pyc' -delete
    dropdb -U atlatl atlatl2
    if createdb -U atlatl atlatl2; then
        time ./manage.py syncdb --migrate --no
        return 0
    else
        echo "ERROR from createdb; see above"
        return 1
    fi
}

function atlatl.create.db.data() {
    time ./manage.py make_test_data --email-domain=bednark.com --num-clients=1 --num-levels=0 --num-configs=1 --num-parts=1 --num-quotes=1 --num-sub-orgs=0 --num-users=1
}

function   atlatl.recreate.db.data.and.runserver() {
    start=$(date)
    if atlatl.recreate.db.only; then
        atlatl.create.db.data
        ./manage.py runserver
    fi
}

function   atlatl.recreate.db.data.and.runserver2() {
    start=$(date)
    if atlatl.recreate.db.only2; then
        atlatl.create.db.data
        ./manage.py runserver 8002
    fi
}
