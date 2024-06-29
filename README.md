# Ultimate Kali Linux WSL Setup for Penetration Testing

This repository provides a script to set up the ultimate penetration testing environment using Kali Linux on Windows Subsystem for Linux (WSL). The script automates the installation of essential tools, pre-configures Firefox with necessary extensions, and integrates seamlessly with Windows. It also includes configuration for HackTheBox (HTB).

## Features

- **Automated Installation**: Sets up Chocolatey on Windows and installs essential software.
- **Kali Linux on WSL**: Installs and configures Kali Linux with essential pentesting tools.
- **Pre-configured Firefox**: Automates the installation of useful browser extensions for penetration testing.
- **Seamless Integration**: Combines Windows and WSL environments for an efficient workflow.
- **HackTheBox Configuration**: Guides you through setting up and connecting to HackTheBox.

## Tools Installed

- **Windows**: VirtualBox, Python, Git, OpenVPN, Wireshark, Visual Studio Code, Firefox
- **Kali Linux**: 
  - **Penetration Testing Tools**: Metasploit Framework, Wireshark, Nmap, John the Ripper, Hydra, Gobuster, DirBuster, Nikto, SQLmap, Medusa, Aircrack-ng
  - **Network Tools**: Net-tools, DNSutils, SMBclient, CIFS-utils
  - **Wordlists**: SecLists, custom wordlists from Daniel Miessler's repository

## Installation

### Prerequisites

- Windows 10 version 2004 and higher or Windows 11
- Administrative privileges

### Steps

1. **Clone the Repository:**

    ```sh
    git clone https://github.com/yourusername/ultimate-kali-wsl.git
    cd ultimate-kali-wsl
    ```

**MUST DO BEFORE RUNNING THE SCRIPT**

2. **Download the HTB VPN Connection Pack:**

    Download your HTB VPN connection pack from your [HackTheBox profile](https://www.hackthebox.eu/) and save it to your Downloads folder.

    - **Start up the box you wish to do on HackTheBox**

3. **Run the Setup Script:**

    Open PowerShell as Administrator and execute:

    ```powershell
    .\setup_kali_wsl.ps1
    ```

4. **Configure HackTheBox:**

    The script will automatically move your HTB VPN config file to the correct location, start the VPN, and prompt you to enter the HTB box IP address. It will then show you the Nmap scan results and prompt you to enter the URL it is failing to redirect to on port 80.

    - Enter the HTB box IP address.
    - Enter the URL it is failing to redirect to on port 80.

## Usage

- **Start Kali Linux GUI:**
    ```sh
    kex
    ```

- **Launch Firefox with extensions:**
    ```sh
    firefox-esr
    ```

## Contributing

Feel free to contribute by submitting issues or pull requests to enhance the script.

## License

This project is licensed under the MIT License.
