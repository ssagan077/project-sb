#!/bin/sh
# shellcheck disable=SC2161,SC1091

# This script is a frontend designed to create & launch a POSIX shell
# environment suitable for use with Easy-RSA. mksh/Win32 is used with this
# project; use with other POSIX shells for Windows may require modification to
# this wrapper script.

setup_path="${EASYRSA:-$PWD}"
export PATH="$setup_path;$setup_path/bin;$PATH"
export HOME="$setup_path"

# This prevents reading from a user's .mkshrc if they have one.
# A user who runs mksh for other purposes might have it
export ENV="/disable-env"

# Verify required externals are present
extern_list="which awk cat cp mkdir printf rm"
for f in $extern_list; do
	if ! which "${f}.exe" >/dev/null 2>&1; then
		echo ""
		echo "FATAL: EasyRSA Shell init is missing a required external file:"
		echo "  ${f}.exe"
		echo "  Your installation is incomplete and cannot function without the required"
		echo "  files."
		echo ""
		echo "  Press enter to exit."
		#shellcheck disable=SC2162
		read
		exit 1
	fi
done

# set_var is defined as any vars file needs it.
# This is the same as in easyrsa, but we _don't_ export
set_var() {
        var="$1"
        shift
        value="$*"
        eval "$var=\"\${$var-$value}\""
} #=> set_var()

# Check for a usable openssl bin, referencing vars if present
[ -r "vars" ] && EASYRSA_CALLER=1 . "vars" 2>/dev/null
if [ -z "$EASYRSA_OPENSSL" ] && ! which openssl.exe >/dev/null 2>&1; then
	echo "WARNING: openssl isn't in your system PATH. The openssl binary must be"
	echo "  available in the PATH, defined in the 'vars' file, or defined in a"
	echo "  named environment variable. See README-Windows.txt for more info."
fi

[ -f "$setup_path/easyrsa" ] || {
	echo "Missing easyrsa script. Expected to find it at: $setup_path/easyrsa"
	exit 2
}

# Set prompt and welcome message
export PS1='
EasyRSA Shell
# '
echo ""
echo "Welcome to the EasyRSA 3 Shell for Windows."
echo "Easy-RSA 3 is available under a GNU GPLv2 license."
echo ""
echo "Invoke './easyrsa' to call the program. Without commands, help is displayed."

# Drop to a shell and await input
###### bin/sh

#Check parameters
if [ $# -eq 0 ]; then
   echo "Must be 1 parameter - client name! For example: make_req.sh client1"
   exit 1
fi

cli_name=$1

if [ ! -f "vars_tmpl" ]; then "Can't find file vars_tmpl. Please ask your company's admin"; exit 1; fi
cp vars_tmpl pki/vars && echo "Template copied" || exit 1
if [ ! -f "pki/reqs/${cli_name}.req" ]; then
    ./easyrsa gen-req ${cli_name} nopass && echo "Request has been created"
    if [ $? -ne 0 ]; then echo "Can't generate request. Please check log files"; exit 1; fi
    #Copying client secret key
    if [ -f "pki/private/${cli_name}.key" ]; then
       cp "pki/private/${cli_name}.key" ../config/client.key && echo "Key ${cli_name}.key has been copied to config folder as client.key"
    else      
       echo "ERROR: There is no ${cli_name} secret key! Abort"
       exit 1
    fi
else
    echo "Client request already exists in folder pki/reqs. Please, send it to Administrator"
fi

echo "Next step: send request pki/reqs/${cli_name}.req to your company's administrator"
