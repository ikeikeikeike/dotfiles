#!/bin/sh
dirs -v -l | awk '{
    a[$1]=$2;
    b[$1]=$2;
}
END{
    for( i=0; i<NR; i++){
        work=a[i];
        checknum=0;
        for( j=i+1; j<NR; j++){
            if( work == a[j] ){
                b[j] = "skip";
            }
        }
    }
    for ( i=NR-1; i>-1; i--){
        if ( b[i] != "skip"){
            printf("%d %s\n",i,b[i]);
        }
    }
}'
echo "移動したい番号を選んでください。"
read newdir
# 入力値に1をプラスし、その終了ステータスを判定する。
expr 1 + $newdir >/dev/null 2>&1
case $? in
    0 | 1 )var=`dirs -v -l |grep -w $newdir |awk '{printf("%s\n",$2)}'`
        cd $var;;
    * ) echo " 数字以外が入力されました >$newdir" ;;
esac
