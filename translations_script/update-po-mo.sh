#!/bin/bash

#make po files

RESOURCE="mx-rofi-manager"

lang="am ar bg ca cs da de el es et eu fa fi fr fr_BE he_IL hi hr hu id is it ja kk ko lt mk mr nb nl pl pt pt_BR ro ru sk sl sq sr sv tr uk zh_CN zh_TW"

make_po()
{
for val in $lang; do
    if [ ! -e "po/$val/$RESOURCE.po" ]; then
        mkdir -p po/$val
        msginit --input=po/"$RESOURCE".pot --no-translator --locale=$val --output=po/$val/"$RESOURCE".po
    else
        msgmerge --update po/$val/$RESOURCE.po po/$RESOURCE.pot
    fi
done
}

make_pot()
{
if [ ! -d "pot" ]; then
    mkdir pot
fi
xgettext --language Shell  --add-comments --sort-output -o pot/$RESOURCE.pot ../mx-rofi-manager
xgettext --language Desktop --join --add-comments -o pot/$RESOURCE.pot ../xdg/mx-rofi-manager.desktop.in
}


make_mo()
{
	if [ -d mo ]; then
		rm -R mo
	fi
    for i in $(ls -1 po/*.po); do
    	val=$(basename $i |cut -d"." -f1 |cut -d"_" -f2-3)
    	echo $val
        if [ -e $i ]; then
            echo $i
            mkdir -p mo/usr/share/locale/$val/LC_MESSAGES
            msgfmt --output-file=mo/usr/share/locale/$val/LC_MESSAGES/"$RESOURCE".mo "$i"
         fi
    done
}

po()
{
    make_pot
    make_po
}

mo()
{
    make_mo
}

pot() 
{
	make_pot
}

main()
{
    $1 
    $2
}

main "$@"


