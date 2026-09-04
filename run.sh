#!/bin/bash
# Run Minecraft Custom Client

echo ""
echo "Starting Minecraft Custom Client..."
echo ""

if [ ! -d "bin" ]; then
    echo "[ERROR] Project not compiled! Run setup.sh first."
    exit 1
fi

java -cp "bin:lib/*" -Djava.library.path=lib client.MinecraftClient
