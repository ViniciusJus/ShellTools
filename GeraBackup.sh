#!/bin/bash

##################################################################################
# Autor: Vinicius Justino (justdgoncalves@protonmail.com)			 #
#			  (viniciusjdgoncalves@gmail.com)			 #
# 14/12/17									 #
# Descrição:									 #
#		Script para gerar back do /home do usuário atual.                #
# Modo de Uso:									 #
#		./GeraBackup							 #
##################################################################################


DESTINO=$HOME/Backup

if [ ! -d $DESTINO ]
then
	echo "Criando Diretório $DESTINO ..."
	mkdir -p $DESTINO
fi

DAYS7=$(find $DESTINO -ctime -7 -name backup_home\*tgz)

if [ "$DAYS7" ]
then
	echo "Já foi gerado um backup do diretório $HOME nos últimos 7 dias."
	echo -n "Deseja continuar? (N/s)"
	read -n1 CONT
	echo
	if [ $CONT = s -o $CONT = S ]
	then
		echo "Será criado mais um backup para a mesa semana"
	elif [ $CONT = N -o $CONT = n -o $CONT = "" ]
	then
		echo "Backup Abortado!"
		exit 1
	else
		echo "Opção Inválida"
		exit 2
	fi
fi

echo "Criando Backup ..."
ARQ="backup_home_$(date +%Y%m%d%H%M).tgz"
tar zcvpf $DESTINO/$ARQ --absolute-names --exclude="$HOME/Música" --exclude="$HOME/Vídeos" --exclude="$DESTINO" "$HOME"/* > /dev/null


echo
echo "O backup de nome \""$ARQ"\" foi criado em $DESTINO"
echo 
echo "Backup Concluído!"

	
