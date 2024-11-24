#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'  # No color

# Function to print the animated banner (Port Scanner)
function print_banner() {
    local lines=(
        " ██████╗  ██████╗ ██████╗ ████████╗    ███████╗ ██████╗  █████╗ ███╗   ██╗███╗   ██╗███████╗██████╗  "
        " ██╔══██╗██╔═══██╗██╔══██╗╚══██╔══╝    ██╔════╝██╔═══   ██╔══██╗████╗  ██║████╗  ██║██╔════╝██╔══██╗ "
        " ██████╔╝██║   ██║██████╔╝   ██║       ███████╗██║      ███████║██╔██╗ ██║██╔██╗ ██║█████╗  ██████╔╝ "
        " ██╔═══╝ ██║   ██║██╔══██╗   ██║       ╚════██║██║      ██╔══██║██║╚██╗██║██║╚██╗██║██╔══╝  ██╔══██╗ "
        " ██║     ╚██████╔╝██║  ██║   ██║       ███████║╚██████╔╝██║  ██║██║ ╚████║██║ ╚████║███████╗██║  ██║ "
        " ╚═╝      ╚═════╝ ╚═╝  ╚═╝   ╚═╝       ╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝ "
    )
    local delay=0.0001  # Delay between characters

    for line in "${lines[@]}"; do
        for ((i=0; i<${#line}; i++)); do
            echo -n -e "${RED}${line:$i:1}${NC}"
            sleep $delay
        done
        echo  # Move to the next line
    done 
}

# Display the animated banner once
print_banner

# Function to prompt for IP input
function get_target_ip() {
    read -p "Enter the target IP address: " TARGET_IP
}

# Function to display the menu
function display_menu() {
    echo -e "${YELLOW}"
    echo "Select an option:"
    echo "1. Ping Scan"
    echo "2. Fast Port Scan"
    echo "3. Specific Port Scan"
    echo "4. Service Version Detection"
    echo "5. Operating System Detection"
    echo "6. Traceroute Scan"
    echo "7. TCP SYN Scan"
    echo "8. UDP Scan"
    echo "9. Vulnerability Scan"
    echo "10. HTTP Service Scan"
    echo "0. Exit"
    echo -e "${NC}"
}

# Function for each menu option

# 1. Ping Scan
function ping_scan() {
    echo -e "${GREEN}[*] Running Ping Scan on $TARGET_IP...${NC}"
    nmap -sn $TARGET_IP
}

# 2. Fast Port Scan
function fast_scan() {
    echo -e "${GREEN}[*] Running Fast Port Scan on $TARGET_IP...${NC}"
    nmap -F $TARGET_IP
}

# 3. Specific Port Scan (new option)
function specific_port_scan() {
    read -p "Enter the port or ports to scan (e.g., 22 or 80,443 or 1-1000): " PORTS
    echo -e "${GREEN}[*] Scanning specific port(s) $PORTS on $TARGET_IP...${NC}"
    nmap -p $PORTS $TARGET_IP
}

# 4. Service Version Detection
function service_version_scan() {
    echo -e "${GREEN}[*] Detecting Service Versions on $TARGET_IP...${NC}"
    nmap -Pn -sV $TARGET_IP
}

# 5. Operating System Detection
function os_detection() {
    echo -e "${GREEN}[*] Running OS Detection on $TARGET_IP...${NC}"
    nmap -O $TARGET_IP
}

# 6. Traceroute Scan
function traceroute_scan() {
    echo -e "${GREEN}[*] Running Traceroute Scan on $TARGET_IP...${NC}"
    nmap --traceroute $TARGET_IP
}

# 7. TCP SYN Scan (Stealth Scan)
function syn_scan() {
    echo -e "${GREEN}[*] Running TCP SYN Scan on $TARGET_IP...${NC}"
    nmap -sS $TARGET_IP
}

# 8. UDP Scan
function udp_scan() {
    echo -e "${GREEN}[*] Running UDP Scan on $TARGET_IP...${NC}"
    nmap -sU $TARGET_IP
}

# 9. Vulnerability Scan with Nmap Scripting Engine (NSE)
function vulnerability_scan() {
    echo -e "${GREEN}[*] Running Vulnerability Scan on $TARGET_IP...${NC}"
    nmap -sV --script vulners $TARGET_IP
}

# 10. Scan for Open HTTP Services
function http_service_scan() {
    echo -e "${GREEN}[*] Scanning for Open HTTP Services on $TARGET_IP...${NC}"
    nmap -p 80,443 --open $TARGET_IP
}

# Main logic to prompt for IP once and then display the menu in a loop
read -p "Enter the target IP address: " TARGET_IP

while true; do
    display_menu
    read -p "Enter your choice: " choice

    case $choice in
        1)
            ping_scan
            ;;
        2)
            fast_scan
            ;;
        3)
            specific_port_scan
            ;;
        4)
            service_version_scan
            ;;
        5)
            os_detection
            ;;
        6)
            traceroute_scan
            ;;
        7)
            syn_scan
            ;;
        8)
            udp_scan
            ;;
        9)
            vulnerability_scan
            ;;
        10)
            http_service_scan
            ;;
        0)
            echo -e "${RED}Exiting...${NC}"
            exit 0
            ;;
        *)
            echo -e "${RED}Invalid option! Please select a valid number.${NC}"
            ;;
    esac

    # Pause to view output before returning to the menu
    echo -e "${YELLOW}Press Enter to continue...${NC}"
    read
done
