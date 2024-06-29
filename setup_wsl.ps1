# Install Chocolatey on Windows
Set-ExecutionPolicy Bypass -Scope Process -Force
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
Invoke-WebRequest https://chocolatey.org/install.ps1 -UseBasicParsing | Invoke-Expression

# Install essential software using Chocolatey
choco install -y virtualbox python git openvpn wireshark vscode firefox

# Enable WSL and install Kali Linux
wsl --install -d kali-linux
Start-Sleep -Seconds 30

# Set up Kali Linux in WSL
wsl -e bash -c "
sudo apt update && sudo apt upgrade -y &&
sudo apt install -y kali-linux-large kali-win-kex firefox-esr metasploit-framework wireshark nmap john hydra gobuster dirb nikto sqlmap \
net-tools dnsutils smbclient cifs-utils medusa aircrack-ng python3-pip seclists wordlists &&
pip3 install --upgrade pip

# Install additional wordlists
if [ ! -d '/usr/share/wordlists' ]; then
    sudo mkdir -p /usr/share/wordlists
fi
cd /usr/share/wordlists
sudo wget https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/Web-Content/raft-large-directories.txt
sudo wget https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/Web-Content/raft-large-files.txt

# Install Firefox extensions
FIREFOX_PROFILE=\$(Get-ChildItem ~/.mozilla/firefox | grep .default-esr)
EXTENSIONS=(
    'https://addons.mozilla.org/firefox/downloads/file/3709964/foxyproxy_standard-7.5.1-an+fx.xpi'
    'https://addons.mozilla.org/firefox/downloads/file/3736570/hacktools-0.9.8-an+fx.xpi'
    'https://addons.mozilla.org/firefox/downloads/file/3705843/wappalyzer-6.8.23-an+fx.xpi'
    'https://addons.mozilla.org/firefox/downloads/file/3576958/cookie_editor-1.10.0-an+fx.xpi'
)
for EXTENSION in \${EXTENSIONS[@]}; do
    firefox-esr -P \$FIREFOX_PROFILE --install-addon \$EXTENSION
done

# Move HTB VPN configuration file from Downloads to OpenVPN folder
HTB_CONFIG=\$(Get-ChildItem /mnt/c/Users/\$USER/Downloads/*.ovpn | head -n 1)
sudo mv \$HTB_CONFIG /etc/openvpn/

# Start the VPN
sudo openvpn /etc/openvpn/\$(basename \$HTB_CONFIG) &

# Sleep to ensure VPN is connected
sleep 20

# Prompt user for HTB Box IP
read -p 'Enter the HTB box IP address: ' HTB_BOX_IP

# Find HTB URL with Nmap
echo 'Running Nmap to find open web ports...'
nmap_result=\$(sudo nmap -p 80,443 --open -sV \$HTB_BOX_IP)

echo '\$nmap_result'

# Prompt user for URL based on Nmap scan
read -p 'What URL is it failing to redirect to on port 80? (e.g., boxname.htb): ' HTB_URL
echo '\$HTB_BOX_IP \$HTB_URL' | sudo tee -a /etc/hosts

echo 'Configuration complete! Access your HTB box at http://$HTB_URL'
"
Write-Host "Initial setup complete. Please manually install Burp Suite from https://portswigger.net/burp and configure your tools as needed."
