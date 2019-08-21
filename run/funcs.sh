# ----
# $1 is the properties file
# ----
PROPS=$1
if [ ! -f ${PROPS} ] ; then
    echo "${PROPS}: no such file" >&2
    exit 1
fi

# ----
# getProp()
#
#   Get a config value from the properties file.
# ----
function getProp()
{   
    grep "^${1}=" ${PROPS} | sed -e "s/^${1}=//"
}
# ----
# getCP()
#
#   Determine the CLASSPATH based on the database system.
# ----
function setCP()
{
dbtmp=$(getProp db)
    if [[ $dbtmp =~ "firebird" ]] ; then
        cp="../lib/firebird/*:../lib/*"
    elif
        [[ $dbtmp =~ "oracle" ]] ; then
        cp="../lib/oracle/*"
            if [ ! -z "${ORACLE_HOME}" -a -d ${ORACLE_HOME}/lib ] ; then
                cp="${cp}:${ORACLE_HOME}/lib/*"
            fi
            cp="${cp}:../lib/*"
    elif
        [[ $dbtmp =~ "postgres" ]] ; then
        cp="../lib/postgres/*:../lib/*"
    elif
        [[ $dbtmp =~ "mysql" ]] ; then
        echo "in mysql"
        cp="../lib/mysql/*:../lib/*"
    elif
        [[ $dbtmp =~ "ddb" ]] ; then
        cp="../lib/ddb/*:../lib/mysql/*:../lib/*"
    else
        echo  "What?"
    fi
    echo ${cp}
    myCP=".:${cp}:../dist/*"
    export myCP
}
# ----
# Make sure that the properties file does have db= and the value
# is a database, we support.
# ----
#case "$(getProp db)" in
#    firebird|oracle|postgres|mysql|ddb)
#	;;
#    "")	echo "ERROR: missing db= config option in ${PROPS}" >&2
#	exit 1
#	;;
#    *)	echo "ERROR: unsupported database type 'db=$(getProp db)' in ${PROPS}" >&2
#	exit 1
#	;;
#esac

