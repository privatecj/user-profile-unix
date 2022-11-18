docker run --restart always -e AZP_URL=https://dev.azure.com/srikrishnas -e AZP_TOKEN=5zjrjrxrbxhf4u6mu4r335vkez3fzvs5dvkhuriu7qqjrdenleza -e AZP_POOL="Self Hosted Pool" cc:latest --once
watch -n 1 docker run --restart always -e AZP_URL=https://dev.azure.com/srikrishnas -e AZP_TOKEN=5zjrjrxrbxhf4u6mu4r335vkez3fzvs5dvkhuriu7qqjrdenleza -e AZP_POOL="Self Hosted Pool" cc:latest --once

while sleep 1; 
docker run --restart always -e AZP_URL=https://dev.azure.com/srikrishnas -e AZP_TOKEN=5zjrjrxrbxhf4u6mu4r335vkez3fzvs5dvkhuriu7qqjrdenleza -e AZP_POOL="Self Hosted Pool" cc:latest --once
done


while true
do 
    docker run --rm -e AZP_URL=https://dev.azure.com/srikrishnas -e AZP_TOKEN=5zjrjrxrbxhf4u6mu4r335vkez3fzvs5dvkhuriu7qqjrdenleza -e AZP_POOL="Self Hosted Pool" cc:latest --once
done



Visual Studio Code
Sublime Text
Atom


Intellij IDEA
Eclipse
Netbeans
STS
WebStrome

Node
Maven
Gradle


Windows
Mac
