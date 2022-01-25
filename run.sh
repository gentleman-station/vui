#/bin/bash

stty -echoctl

# TODO: Custom Ports

export DENO_INSTALL="/home/$USER/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"
export host="127.0.0.1"
export ui_port=8008


quit() {
    tput setaf 1
    rm -rf __pycache__/ vfapi.*.db &
    printf "\n[!] SIGINT trapped, terminating..\n\n"
    tput sgr0
    sleep 0.48
    exit 0
}; trap 'quit' SIGINT


check_dependencies() {
	if ! command -v deno >/dev/null; then
		echo "[-] Deno is not found in the path. Shall I install it?"
		echo -n "[y/N]: "
		read prompt
		if [[ $prompt == "y" || $prompt == "Y" ]]; then
			echo "[+] Installing deno."
			curl -fsSL https://deno.land/install.sh | sh
			export DENO_INSTALL="/home/$USER/.deno"
			export PATH="$DENO_INSTALL/bin:$PATH"
			shells="bash zsh"
			for shell in $shells; do
				dot_filename="~/.${shell}rc"
				if [ -f "$dot_filename" ]; then
					echo "export DENO_INSTALL=\"/home/$USER/.deno\"" >> "$dot_filename"
					echo "export PATH=\"$DENO_INSTALL/bin/:$PATH\"" >> "$dot_filename"
				fi
			done
		else
			echo "[!] Please do make sure 'deno' is available in the \$PATH."
			exit 1
		fi
	fi
	if ! command -v snel >/dev/null; then
		echo "[+] Installing 'snel' (svelte for deno)"
		deno run --allow-run --allow-read https://deno.land/x/snel/install.ts
	fi
	if ! command -v file_server >/dev/null; then
		echo "[+] Installing deno's HTTP server"
		deno install --allow-net --allow-read https://deno.land/std@0.106.0/http/file_server.ts
	fi
}


banner () {
	if command -v figlet >/dev/null; then
		figlet -f small "vUI"
	else
		echo "      _   _ ___ "
 		echo " __ _| | | |_ _|"
 		echo " \ V / |_| || | "
		echo "  \_/ \___/|___|"
	fi
}


check_ports() {
	ui_check=$(nc -zw5 $host $ui_port)
	if [[ $? -eq 0 ]]; then
		echo "[-] Looks like port ://$host:$ui_port/ is already occupied. Please kill/stop the running service conflicting the port number."
		if [[ $1 != "--ignore" ]]; then
			exit 1;
		fi
	fi
}


main() {
	rm -rf __pycache__/ vfapi.*.db
	banner
	printf "\t\tvulnerable User Interface\n"
	check_ports
	check_dependencies
	sleep 0.48
	if [[ $1 == "--dev" ]]; then
		while :; do
			printf "\n[!] Starting Vulnerable API UI <dev>\n"
			trex run start
		done
	else
		printf "\n[+] Starting Vulnerable API UI\n\n"
		snel build
		if [[ -d ./output/dist ]]; then
			mkdir -p ./output/dist
		fi
		cp -f ./public/__index.html ./output/index.html
		cp -f ./public/favicon.ico ./output
		cp -f ./public/global.css ./output
		cp -fr ./public/dist/* ./output/dist/
		file_server ./output
	fi
}

main $1
