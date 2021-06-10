
clear



echo -e " /__  ___/                                         //   ) )                   "        
echo -e "   / /  / __      ___     // //  ___      ___     //___/ /            ___     "___    
echo -e "  / /  //   ) ) //   ) ) // // //___) ) ((   ) ) / __  (   //   / / ((   ) ) //   ) ) "
echo -e " / /  //   / / //   / / // // //         \ \    //    ) ) //   / /   \ \    //   / /  "
echo -e "/ /  //   / / ((___( ( // // ((____   //   ) ) //____/ / ((___( ( //   ) ) ((___/ /  "


echo -e "[Dimension Bot]: Seja bem vindo à aplicação Dimension ʕ•́ᴥ•̀ʔ"
echo -e "[Dimension Bot]: Vamos inicializar a nossa configuração de ambiente..."

echo -e "[Dimension Bot]: Verificando se o Docker está instalado..."
docker -v
if [ $? -eq 0 ]
    then
        echo -e "[Dimension Bot]: O Docker já foi instalado. "
    else
        echo -e "[Dimension Bot]: Não conseguimos encontrar o Docker T.T "
        echo -e "[Dimension Bot]: Gostaria de iniciar a instalação? :3 S/n "
        read inst
        if [ \"$inst\" == \"s\" ]
            then
                echo -e "[Dimension Bot]: Iniciando a instalação do Docker..."
                sleep 2
                sudo apt update && sudo apt install docker.io -y
                clear
                echo -e "[Dimension Bot]: Instalação completa do Docker! ♥"
                sleep 2
            else 
                echo -e "[Dimension Bot]: Você escolheu não instalar... ó_ò"
                exit
        fi
fi   

echo -e "[Dimension Bot]: Inicalizando o Docker..."
sleep 2
sudo systemctl start docker
sudo systemctl enable docker

echo -e "[Dimension Bot]: Docker Iniciado!"

#clear

#Instalação da img MySQL
echo -e "[Dimension Bot]: Instalação da imagem MySQL"
echo -e "[Dimension Bot]: Verificando se existe a imagem MySQL instalado... \(^o^)/"
sleep 1

if [[ ! "$(sudo docker image inspect mysql:5.7)" ]]
    then
        echo -e "[Dimension Bot]: Imagem do MySQL não foi instalado (>_<)"
        echo -e "[Dimension Bot]: Gostaria de fazer a instalação S/n"
        read inst
        if [ \"$inst\" == \"s\" ]
            then
            echo -e "[Dimension Bot]:Iniciando a instalação do MySQL..."
            sleep 2
            sudo docker pull mysql:5.7

            echo -e "[Dimension Bot]:Instalação completa do MySQL"
            sleep 2
        fi
    else
        echo -e "Imagem MySQL já instalado."
fi

#sleep2
#clear

#Configurando o Container MySQL
echo -e "[Dimension Bot]: Configurando o container MySQL"
echo -e "[Dimension Bot]: Conferindo se existe o container para MySQL"

if [[ ! "$(sudo docker ps -aqf "name=ContainerDimensionBD")" ]]
    then
        echo -e "[Dimension Bot]: Não existe nenhum container... T-T"
        echo -e "[Dimension Bot]: Gostaria de criar o Container? *3*??  S/n"
        read inst
        if [ \"$inst\" == \"s\" ]
            then
            echo -e "[Dimension Bot]: Iniciando a criação do ContainerDimensionBD..."
            sleep 2
            git clone https://github.com/ThallesBuso/AC3_Dimension.git
            cd AC3_Dimension
            cd Dimension
            cd mysql
            sudo docker build -t mysql . 
            cd ..
            cd ..            
            #permissão para que funcione o docker.sock - senão nega e da erro
            sudo chmod 666 /var/run/docker.sock
            sudo docker run -d -p 3306:3306 --name ContainerDimensionBD -e "MYSQL_DATABASE=dimensionBD" -e "MYSQL_ROOT_PASSWORD=urubu100" mysql
            #sudo docker run -d -p 3306:3306 --name ContainerDimensionBD -e "MYSQL_DATABASE=dimensionBD" -e "MYSQL_ROOT_PASSWORD=urubu100" mysql:5.7
            
            echo -e "[Dimension Bot]: Configuração completa do MySQL \o/ "
            sleep 2
        fi
    else
        echo -e "[Dimension Bot]: Container MySQL já existe!"
        CONTID=$(sudo docker ps -aqf "name=ContainerDimensionBD")
        #sudo docker stop ${CONTID}
        sudo docker start ${CONTID}        
fi

sleep 2
#clear

#Instalação JAVA IMG -VERSION 11
echo -e "[Dimension Bot]: Instalação da imagem Java"
echo -e "[Dimension Bot]: Verificando se existe a imagem Java 11 instalado..."
sleep 1

if [[ ! "$(sudo docker image inspect openjdk:11)" ]]
    then
        echo -e "[Dimension Bot]: Não existe nenhuma imagem do Java 11..."
        echo -e "[Dimension Bot]: Gostaria de instalar agora? S/n"
        read inst

        if [ \"$inst\" == \"s\" ]
            then
                echo -e "[Dimension Bot]: Instalação da imagem do Java 11 será iniciado"
                sudo docker pull openjdk:11
                echo -e "[Dimension Bot]: Imagem Java 11 instalado!"
            else
                echo -e "[Dimension Bot]: Okay... Vamos parar a instalação T-T "
                exit
        fi
    else
        echo -e \"Imagem Java já foi instalada\"
fi

    
echo -e "[Dimension Bot]: Verificando se Container Java existe"
if [[ ! "$(sudo docker ps -aqf "name=java-jar")" ]]
    then
        echo -e "[Dimension Bot]: O dimensionjava não existe"
        echo -e "[Dimension Bot]: Inicializando a criação..."
        sleep 1
        cd AC3_Dimension/Dimension/ApiMysql/target
        chmod 777 DimensionJar.jar
        sudo docker build -t dimensionjava .
        sudo docker run -d --name='java-jar' -t dimensionjava
        sudo docker cp DimensionJar.jar java-jar:/
        sudo docker exec -it java-jar java -jar DimensionJar.jar
        
    else
        CONTID=$(sudo docker ps -aqf "name=java-jar")
        sudo docker stop ${CONTID}
        sudo docker start ${CONTID}
        echo -e "[Dimension Bot]: Container já existe, iniciando o Container..."
        cd AC3_Dimension/
        cd Dimension/
        cd ApiMysql/
        cd target
        chmod 777 DimensionJar.jar
        sudo docker build -t dimensionjava .
        sudo docker cp DimensionJar.jar java-jar:/
        sudo docker exec -it java-jar java -jar DimensionJar.jar
fi

echo -e "[Dimension Bot]: Obrigada por escolher a aplicação Dimension ♥"

# this version made by: Priscila Choi
#        ...                                     .    
#     xH88"`~ .x8X      .uef^"                  @88>  
#   :8888   .f"8888Hf :d88E              u.     %8P   
#  :8888>  X8L  ^""`  `888E        ...ue888b     .    
#  X8888  X888h        888E .z8k   888R Y888r  .@88u  
#  88888  !88888.      888E~?888L  888R I888> ''888E` 
#  88888   %88888      888E  888E  888R I888>   888E  
#  88888 '> `8888>     888E  888E  888R I888>   888E  
#  `8888L %  ?888   !  888E  888E u8888cJ888    888E  
#   `8888  `-*""   /   888E  888E  "*888*P"     888&  
#     "888.      :"   m888N= 888>    'Y"        R888" 
#       `""***~"`      `Y"   888                 ""   
#                           J88"                      
#                           @%                        
#                         :"                          


#===================================================================
# Todos os direitos reservados para os autores: Grupo 10 - Dimension
# Sob licença Creative Commons @2021
# Poderá modificar e reproduzir para uso pessoal
# Proibida a comercialização e a exclusão da autoria
# Agradecimentos aos professores Dra. Profa. Marise Miranda e
# Prof. Márcio Santana
#===================================================================

#Extra commands:
# stop docker = sudo docker stop contianerID
# delete docker =    (container must be stopped first)
# remove all stopped containers = sudo docker container rm $(docker container ls -aq)
# Remove ALL dockers containers(clean container) = sudo docker container stop $(docker container ls -aq) && sudo docker system prune -af --volumes
# delete directory with file = rm -r nameDir (y y)
# delete file = rm filename
#comando de execução no bash do container = sudo docker exec -it  ${CONTID} bash