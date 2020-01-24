update:
	@git remote set-url origin git://gitlab.com/FG42/FG42.git
	@git pull origin master
install:
	@echo "Downloading and installing fonts..."
	@mkdir -p ~/.fonts
	@wget "https://github.com/FG42/fonts/archive/0.1.0.tar.gz" -O ~/.fonts/fg42.tar.gz
	@tar zxf ~/.fonts/fg42.tar.gz -C ~/.fonts --strip 1
	@cp ./config/fg42.user.el ${HOME}/.fg42.el
	@echo "Creating the link..."
	@echo "#! /bin/sh" > ./fg42
	@echo "export FG42_HOME=$(shell pwd)" >> ./fg42
	@echo 'emacs --name FG42 --no-site-file --no-site-lisp --no-splash --title FG42 -l $$FG42_HOME/fg42-config.el "$$@"' >> ./fg42
	@chmod +x ./fg42
	@[ `which fg42` ] && echo "\033[32;1mfg42 already exists\033[0m" ||  echo 'export PATH="$$PATH:$$HOME/fg42"' > $$HOME/.profile
	@[ `which fg42` ] && echo "\033[32;1mfg42 already exists\033[0m" ||  echo 'export PATH="$$PATH:$$HOME/fg42"' > $$HOME/.zshrc
	@[ `which fg42` ] && echo "\033[32;1mfg42 already exists\033[0m" ||  echo 'export PATH="$$PATH:$$HOME/fg42"' > $$HOME/.bashrc
	@# sudo rm -f /usr/local/bin/fg42
	@# sudo ln -s `pwd`/fg42 /usr/local/bin/fg42
	@echo "Copying share files..."
	@bash -c "[ "`whoami`" == "root" ] && mkdir -p /usr/share/fg42/ || echo not root "
	@bash -c "[ "`whoami`" == "root" ] && cp -r ./share/* /usr/share/fg42/ || echo not root "
	@echo " "
	@echo "------------------------------------------------------------------------------------"
	@echo "Make sure to install external dependencies of FG42. For more info checkout README.md"
	@echo "Enjoy the bless of GNU/Emacs and FG42 :)"
install-fonts:
	@mkdir -p ~/.fonts/
	@cp -rv ./share/fonts/vazir/* ~/.fonts/
build-image:
	docker build . -t fg42:1 --build-arg emacs_version=26.3

clean-image:
	docker rmi fg42:1
