#!/bin/sh

RYAKU_TXT="RYAKU144.TXT"
EIJIRO_TXT="EIJI-144.TXT"
MY_DICTIONARY_XML="MyDictionary.xml"

create_xml()
{
    ryaku_tmp_txt="Ryaku.txt"
    eijiro_tmp_txt="Eijiro.txt"
    eijiro_head_txt="Eijiro_head.txt"
    
    echo "##### create Eijiro.txt #####" 1>&2
    echo "create $ryaku_tmp_txt"
    ruby -Ks ryaku_conv.rb < $RYAKU_TXT > $ryaku_tmp_txt
    echo "create $eijiro_tmp_txt"
    ruby -Ks cat.rb $EIJIRO_TXT $ryaku_tmp_txt > $eijiro_tmp_txt
    if [ "$TEST_DICT" = true ]; then
	  echo "create small $eijiro_tmp_txt"
	  head -10 $eijiro_tmp_txt > $eijiro_head_txt
	  mv $eijiro_head_txt $eijiro_tmp_txt
    fi
    echo "create $MY_DICTIONARY_XML"
    ruby eiji_conv.rb < $eijiro_tmp_txt > $MY_DICTIONARY_XML
}


TASKNAME=${1:-default normal}
if [ "$TASKNAME" = "normal" ]; then
    TEST_DICT=false
    create_xml
elif [ "$TASKNAME" = "test" ]; then
    TEST_DICT=true
    create_xml
else
    echo "unknown task"
fi


