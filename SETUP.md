# Setup Guide

## Prerequisites

- **Java 17 or higher** ([Download](https://www.oracle.com/java/technologies/downloads/))
- **IDE**: IntelliJ IDEA Community (recommended) or Eclipse

## Step 1: Download LWJGL Libraries

Download LWJGL 3.3.2 from [lwjgl.org](https://www.lwjgl.org/download)

You need:
- lwjgl-core
- lwjgl-opengl
- lwjgl-glfw
- joml (for math)
- stb (for image loading)

Extract JAR files to `lib/` folder

## Step 2: Directory Structure

```
minecraft-client/
├── lib/
│   ├── lwjgl.jar
│   ├── lwjgl-opengl.jar
│   ├── lwjgl-glfw.jar
│   ├── joml.jar
│   └── stb.jar
├── src/
│   └── main/
│       ├── java/
│       │   └── client/
│       │       ├── MinecraftClient.java
│       │       ├── renderer/
│       │       ├── texture/
│       │       └── util/
│       └── resources/
│           ├── shaders/
│           └── textures/
├── config.properties
└── README.md
```

## Step 3: Add Skybox Textures

Create folders: `src/main/resources/textures/skybox/`

Add 6 PNG/JPG images:
- `sky_north.png` (1024x1024)
- `sky_south.png`
- `sky_east.png`
- `sky_west.png`
- `sky_up.png`
- `sky_down.png`

## Step 4: Compile

```bash
# Compile all Java files
javac -cp "lib/*" -d bin src/main/java/client/*.java src/main/java/client/*/*.java

# Run
java -cp "bin:lib/*" -Djava.library.path=lib client.MinecraftClient
```

## Step 5: IntelliJ Setup (Optional)

1. Open project in IntelliJ
2. File → Project Structure
3. Libraries → Add JAR files from `lib/` folder
4. Mark `src/main/java` as Sources
5. Mark `src/main/resources` as Resources
6. Run → Edit Configurations
7. Add new Application config:
   - Main class: `client.MinecraftClient`
   - VM options: `-Djava.library.path=lib`

## Troubleshooting

**"Cannot find symbol" errors:**
- Ensure all JAR files are in `lib/` folder
- Add them to classpath: `-cp "lib/*"`

**"UnsatisfiedLinkError":**
- Download LWJGL native libraries for your OS
- Place in `lib/` folder
- Use: `java -Djava.library.path=lib -cp "bin:lib/*" client.MinecraftClient`

**Graphics not working:**
- OpenGL 3.3+ required
- Update GPU drivers

## Next Steps

1. Create custom skybox textures
2. Modify shaders (skybox.vert, skybox.frag)
3. Add more shader effects
4. Implement camera controls
