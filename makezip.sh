git clean -x -f -d
./install.sh

VERSION="2.5.9"
wcrev=`git log -1 --pretty=format:%h`
if [ "$1" == "" ]
then
    extversion=${VERSION}.${wcrev}
else
    extversion=${VERSION}-$1.${wcrev}
fi
NAME="blender_nif_scripts"
FILES="scripts/import/import_nif.py scripts/export/export_nif.py scripts/bpymodules/nif_common.py scripts/bpymodules/nif_test.py scripts/mesh/mesh_niftools_weightsquash.py scripts/mesh/mesh_niftools_hull.py scripts/object/object_niftools_set_bone_priority.py scripts/object/object_niftools_save_bone_pose.py scripts/object/object_niftools_load_bone_pose.py scripts/mesh/mesh_niftools_morphcopy.py ChangeLog README.html install.sh install.bat docs/*.*"

# update documentation
rm -rf docs
blender -P runepydoc.py

rm -f "${NAME}-${VERSION}"*
zip -9 "${NAME}-${extversion}.zip" ${FILES}
tar cfvj "${NAME}-${extversion}.tar.bz2" ${FILES}

# create windows installer
rm -f "win-install/${NAME}-${VERSION}-windows.exe"
makensis -V3 win-install/${NAME}.nsi
mv "win-install/${NAME}-${VERSION}-windows.exe" "win-install/${NAME}-${extversion}-windows.exe"
