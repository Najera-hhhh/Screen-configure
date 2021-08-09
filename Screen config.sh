#!/bin/bash
# get info from xrandr
connectedOutputs=$(xrandr | awk '$2 == "connected"{print $1}')
activeOutput=$(xrandr | grep -E " connected (primary )?[1-9]+" | sed -e "s/\([A-Z0-9]\+\) connected.*/\1/")

screens=( $activeOutput )
cont=0

echo -e "elije la pantalla que quieras configurar:"

#Print the split string
for i in "${screens[@]}"
do
	cont=$((cont + 1))
    echo $cont") "$i
done



echo -n "Escribe un numero: "
read scr

cont=0
resolution=("1280x720" "1920x1080" "2560x1440" "3840x2160" "manual")

resolution_arr=( $resolution )

echo -e "\n\nEscribe un numero para la resolucion:" 

#Print the split string
for i in "${resolution[@]}"
do
        cont=$((cont + 1))
    echo $cont") "$i
done

echo -n "Opcion: " 
read size;


#read maunal size 
if [ $size -eq 5 ]
then
	echo -n "tamaño: "
	read resolution[4];
	echo ${resolution[4]};
fi



disponibles=( $screens )
unset disponibles[$((scr-1))]

if [ ${#disponibles[@]} -gt 0 ]
then
    cont=0
    direction=("left" "right" "up" "down")

    echo -e " \n ¿Que posicion debe tomar la pantalla?: "
    #Print the split string
    for i in "${direction[@]}"
    do
            cont=$((cont + 1))
        echo $cont") "$i
    done

    echo -n "Opcion: "
    read dir

    cont=0

    echo -e "\n¿${direction[(dir-1)]} de que pantalla?: "

    #Print the split string
    for i in "${disponibles[@]}"
    do
        cont=$((cont + 1))
    echo $cont") "$i
    done

    echo -n "Opcion: "
    read dir_src


    echo "Configurando " ${screens[(src-1)]} "con la resolucion de " ${resolution[(size-1)]} " ${direction[(dir-1)]} de ${disponibles[(dir_scr-1)]}"
    newSize=($(echo ${resolution[(size-1)]} | tr "x" "\n"))
    textResolution=$(cvt ${newSize[0]} ${newSize[1]} 60);
    newResolution=( $textResolution )

    xrandr --newmode ${newResolution[13]}  ${newResolution[14]}  ${newResolution[15]} ${newResolution[16]} ${newResolution[17]} ${newResolution[18]}  ${newResolution[19]} ${newResolution[20]} ${newResolution[21]} ${newResolution[22]} ${newResolution[23]} ${newResolution[24]};
    xrandr --addmode ${screens[(src-1)]} ${newResolution[13]};
    xrandr --output ${screens[(src-1)]}  --mode ${newResolution[13]} --${direction[(dir-1)]}-of ${disponibles[(dir_scr-1)]};

    echo "¿Deseas generar un script para ejecutarlo sin tener que hacer este proceso de nuevo? [s/n]:"
    read resp
    if [ $resp == "s" ]
    then
        touch "pantalla.sh"
        echo "xrandr --newmode ${newResolution[13]}  ${newResolution[14]}  ${newResolution[15]} ${newResolution[16]} ${newResolution[17]} ${newResolution[18]}  ${newResolution[19]} ${newResolution[20]} ${newResolution[21]} ${newResolution[22]} ${newResolution[23]} ${newResolution[24]};" >> pantalla.sh;
        echo "xrandr --addmode ${screens[(src-1)]} ${newResolution[13]};" >> pantalla.sh;
        echo "xrandr --output ${screens[(src-1)]}  --mode ${newResolution[13]} --${direction[(dir-1)]}-of ${disponibles[(dir_scr-1)]};" >> pantalla.sh;
        chmod +x pantalla.sh;
    fi

else

    echo "Configurando " ${screens[(src-1)]} "con la resolucion de " ${resolution[(size-1)]}
    newSize=($(echo ${resolution[(size-1)]} | tr "x" "\n"))
    textResolution=$(cvt ${newSize[0]} ${newSize[1]} 60);
    newResolution=( $textResolution )

    xrandr --newmode ${newResolution[13]}  ${newResolution[14]}  ${newResolution[15]} ${newResolution[16]} ${newResolution[17]} ${newResolution[18]}  ${newResolution[19]} ${newResolution[20]} ${newResolution[21]} ${newResolution[22]} ${newResolution[23]} ${newResolution[24]};
    xrandr --addmode ${screens[(src-1)]} ${newResolution[13]};
    xrandr --output ${screens[(src-1)]}  --mode ${newResolution[13]};


    echo "¿Deseas generar un script para ejecutarlo sin tener que hacer este proceso de nuevo? [s/n]:"
    read resp
    if [ $resp == "s" ]
    then
        touch "pantalla.sh"
        echo "xrandr --newmode ${newResolution[13]}  ${newResolution[14]}  ${newResolution[15]} ${newResolution[16]} ${newResolution[17]} ${newResolution[18]}  ${newResolution[19]} ${newResolution[20]} ${newResolution[21]} ${newResolution[22]} ${newResolution[23]} ${newResolution[24]};" >> pantalla.sh;
        echo "xrandr --addmode ${screens[(src-1)]} ${newResolution[13]};" >> pantalla.sh;
        echo "xrandr --output ${screens[(src-1)]}  --mode ${newResolution[13]};" >> pantalla.sh;
        chmod +x pantalla.sh;
    fi



fi








