# Check if exactly one argument was provided
if [ "$#" -ne 1 ]; then
    echo "Error: Exactly one argument required (-d or -l)." >&2
    echo "Usage: $0 [-d | -l]" >&2
    exit 1
fi

# Evaluate the argument
case "$1" in
    -d)
        echo "building desktop flake..."
        git add .
        sudo nixos-rebuild switch --flake .#niikusu-desktop
        ;;
    -l)
        echo "building laptop flake..."
        git add .
        sudo nixos-rebuild switch --flake .#niikusu-laptop
        ;;
    *)
        echo "Error: Invalid argument '$1'. Only -d or -l are allowed." >&2
        echo "Usage: $0 [-d | -l]" >&2
        exit 1
        ;;
esac

