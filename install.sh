#!/bin/bash
print_help() {
  echo "Usage: $0 [-H <target_host_ip>] [-u <username>] [-h|--help]"
  echo ""
  echo "  -H <target_host_ip>   Set the target host IP address for Ansible."
  echo "  -u <username>         Set the username for Ansible SSH connection."
  echo "  -h, --help            Show this help message and exit."
  exit 0
}

TARGET_HOST=""
USER_NAME=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    -H)
      TARGET_HOST="$2"
      shift 2
      ;;
    -u)
      USER_NAME="$2"
      shift 2
      ;;
    -h|--help)
      print_help
      ;;
    *)
      echo "Unknown option: $1"
      print_help
      ;;
  esac
done

if [[ -z "$TARGET_HOST" || -z "$USER_NAME" ]]; then
  echo "Error: Both -H <target_host_ip> and -u <username> are required."
  print_help
  exit 1
fi

echo "Target host IP: $TARGET_HOST"
echo "Username: $USER_NAME"

echo "Installing dependencies..."
ansible-galaxy install -r ./requirements.yml

PLAYBOOK_CMD="ansible-playbook -k -K -i ${TARGET_HOST}, -e 'ansible_user=${USER_NAME}' playbook.yml"
echo "Running: $PLAYBOOK_CMD"
eval $PLAYBOOK_CMD

if [ $? -eq 0 ]; then
  echo " "
  echo "+==============================+"
  echo "Done! Reboot VM."
  echo "+==============================+"
  echo " "
fi
