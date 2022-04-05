#!/bin/bash

if [ $# != 3 ]
then
	echo "Данный скрипт принимает строго 3 параметра:"
	echo "1) имя файла, в который записывается результат"
	echo "2) имя каталога, в котором будет осуществляться поиск файлов"
	echo "3) расширение, по которому будет осуществляться поиск файлов"
else
	errs=""
	if [[ -f $1 && ! -w $1 ]]; then
		errs+="Ошибка параметра 1: файл для записи недоступен для записи!\n"
	fi
	if [[ ! -d $2 ]]; then
		errs+="Ошибка параметра 2: параметр либо не является каталогом, либо такого каталога не существует!\n"
	fi
	if [[ "$3" == *"."* ]]; then
		errs+="Ошибка параметра 3: расширение не должно иметь '.'!\n"
	fi

	if [[ -n $errs ]]; then
		echo -e "$errs" >&2
	else
		find "$2" -name "*.$3" | sort --output="$1"
		echo "Файлы найдены!"
	fi
fi