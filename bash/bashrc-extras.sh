if [ -z "$(type -t createnv)" ]; then
    echo "Adding createnv() to ~/.bashrc";
    read -d '' createnv <<- "EOF"


# Usage: createnv [virtualenv directory name]
#   Wraps call to virtualenv with extra arguments
#   and places into .env directory.
createnv() {         
	if [[ ! $1 ]]; then                
        echo "Must provide top-level virtualenv directory";		
        return 1;
	fi;  

    mkdir -p $1;
    if [[ $? -gt 0 ]]; then 
        return $?;
    fi    

    cd $1;
    virtualenv --no-site-packages --python=/usr/bin/python2.7 --distribute --prompt="($(basename $1))" .env
    
    if [[ $? -gt 0 ]]; then 
        return $?;
    fi     
    ln -s .env/bin/activate activate
}


EOF
    echo "$createnv" >> $HOME/.bashrc

else
    echo "createnv() already exists ... skipping";
fi
 

# Reload .bashrc
. $HOME/.bashrc


