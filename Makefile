install:
	@echo "Downloading and installing fonts..."
	@mkdir -p ~/.fonts
	@wget "https://github.com/FG42/fonts/archive/0.1.0.tar.gz" -O ~/.fonts/fg42.tar.gz
	@tar zxf ~/.fonts/fg42.tar.gz -C ~/.fonts --strip 1
	@cp ./config/fg42.user.el ${HOME}/.fg42.el
	@echo "Creating the link..."
	@echo "#! /bin/sh" > ./fg42
	@echo "export FG42_HOME=${HOME}/src/FG42" >> ./fg42
	@echo 'emacs --name FG42 --no-site-file --no-site-lisp --no-splash --title FG42 -l $FG42_HOME/fg42-config.el "$$@"' >> ./fg42
	@sudo rm /usr/local/bin/fg42
	@sudo ln -s `pwd`/fg42 /usr/local/bin/fg42
	@echo "Copying share files..."
	@sudo mkdir -p /usr/share/fg42/
	@sudo cp -r ./share/* /usr/share/fg42/
	@echo " "
	@echo "------------------------------------------------------------------------------------"
	@echo "Make sure to install external dependencies of FG42. For more info checkout README.md"
	@echo "Enjoy the bless of GNU/Emacs and FG42 :)"
