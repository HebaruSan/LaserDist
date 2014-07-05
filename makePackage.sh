# Bash script (that should work in gitbash on Windows) that 
# will crate the export ZIP file for installing the mod.

# Run with "bash makePackage" from this directory.


# ------------------------------------------------------------
# CHANGE THE FOLLOWING SETTINGS FOR YOUR OWN FOLDER LOCATIONS:
# ------------------------------------------------------------

# I copied the 7-ZIP 7z.exe file into my github /usr/bin to make this work:
CMD_ZIP="7z"

# Location where your KSP game is installed:
INSTALL_GAME_DIR="../../../../../Program Files (x86)/Steam/steamapps/common/Kerbal Space Program"

# Change this to "no" if you want to suppress the install to your game:
DO_INSTALL="yes"  #

# ------------------------------------------------------------
# YOU SHOULDN'T NEED TO ALTER THE LINES FROM HERE DOWN:
# ------------------------------------------------------------

EXPORT_DIR="./GameData"
MOD_NAME="LaserDist"

if [ -e "$EXPORT_DIR" ]
then
  echo "$EXPORT_DIR exists.  Clearing it out."
  rm -r "$EXPORT_DIR"
fi

if [ -e "${MOD_NAME}.zip" ]
then
  echo "${MOD_NAME}.zip exists.  Removing it."
  rm "${MOD_NAME}.zip"
fi

echo "-----------------------------------------"
echo "Staging files for ZIPping in $EXPORT_DIR."
echo "-----------------------------------------"
mkdir "$EXPORT_DIR"
mkdir "${EXPORT_DIR}/${MOD_NAME}"
cp -r Parts "${EXPORT_DIR}/${MOD_NAME}/"
mkdir "${EXPORT_DIR}/${MOD_NAME}/Plugins"
cp -r src/LaserDist/bin/Debug/LaserDist.dll "${EXPORT_DIR}/${MOD_NAME}/Plugins"
"$CMD_ZIP" a "${MOD_NAME}.zip" "${EXPORT_DIR}"

if [ "$DO_INSTALL" = "yes" ]
then
  echo "-----------------------------------------------"
  echo "ZIP File made, now installing to your KSP Game."
  echo "-----------------------------------------------"
  cp "${MOD_NAME}.zip" "${INSTALL_GAME_DIR}"
  cd "${INSTALL_GAME_DIR}"
  "$CMD_ZIP" x -y "${MOD_NAME}.zip" 
  rm "${MOD_NAME}.zip"
else
  echo "----------------------"
  echo "Skipping Install Step."
  echo "----------------------"
fi