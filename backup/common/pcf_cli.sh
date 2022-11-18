function pcf-dev-login(){
    for x in 1 2 3; do
        echo "verify is there any active cf session remaining";
        cf target;
        RESULT=$?
        if [ $RESULT -eq 0 ]; then
            echo "active cf session available. skipping login. changing space";
            cf target -o IDA_AZURE_US_EAST_Preprod -s IDA-dev;
            break;
        else
            echo "there is not active cf session available. trying to create one":
            explorer.exe https://login.sys.pp01.useast.cf.ford.com/passcode
            cf login -a https://api.sys.pp01.useast.cf.ford.com -o IDA_AZURE_US_EAST_Preprod -s IDA-dev --sso;
        fi
    done
}


function log-utm-dev(){
    cf logs ida-utm-dev | rotatelogs.exe -f test.log 1M
}

function log-polling-dev(){
    pcf-dev-login
    random_file=$TEMP_DIR"/polling.log"
    echo $random_file
    cat /dev/null > $random_file
    glogg $random_file &
    cf logs ida-polling-dev | rotatelogs -f -n 3 $TEMP_DIR/polling.log 5M
}

function log-cg-dev(){
    pcf-dev-login;
    random_file="$(randomfilefun)";
    touch $random_file;
    glogg $random_file &
    cf logs ida-cg-dev | tee $random_file;
}

function log-ag-dev(){
    pcf-dev-login;
    random_file="$(randomfilefun)";
    touch $random_file;
    glogg $random_file &
    cf logs ida-ag-dev | tee $random_file;
}

function log-cs-dev(){
    pcf-dev-login;
    random_file="$(randomfilefun)";
    touch $random_file;
    glogg $random_file &
    cf logs ida-cs-dev | tee $random_file;
}