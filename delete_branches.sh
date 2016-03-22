echo -n "Enter your branches' prefix: "
read prefix

echo "############################################################"
echo "PLEASE MAKE SURE TO ONLY DELETE BRANCHES THAT YOU CREATED !!"
echo "############################################################"

git fetch -p
for x in `git branch | grep -i $prefix`; do
  shopt -s extglob
  branch_name="${x##*( )}"
    if [ ${branch_name} = "develop" ] || [ "${branch_name}" = "master" ]
    then
            continue
    fi
  ask_again=true
  while ${ask_again}; do
   read -p "Delete $branch_name locally and on remote?" yn
      case $yn in
            [Yy]* ) echo "Deleting.."
                    git branch -D ${branch_name}
                    git push origin :${branch_name}
                    ask_again=false;;

            [Nn]* ) echo "Skipping..."
                    ask_again=false;;

           "exit"* ) exit 1;;

           * ) echo "Please answer yes or no. Type 'exit' anytime to Exit";;
       esac
  done
done
shopt -u extglob
