#!/usr/bin/env zsh
i=0
for j in {0..12}; do
  cp "../Shaders/Tile.gdshader" "../Shaders/${j}Tile.gdshader"
done
while IFS= read -r line; do
  s1="$(("0x${line:1:2}"/300.0))"
  s2="$(("0x${line:3:2}"/300.0))"
  s3="$(("0x${line:5:2}"/300.0))"
  if [ $((i%2)) = 0 ]
  then
    sed -i "s|^const vec4 PRIMARY_COLOR.*;$|const vec4 PRIMARY_COLOR=vec4(${s1},${s2},${s3},1);|" "../Shaders/$((i/2))Tile.gdshader"
  else
    sed -i "s|^const vec4 SECONDARY_COLOR.*;$|const vec4 SECONDARY_COLOR=vec4(${s1},${s2},${s3},1);|" "../Shaders/$((i/2))Tile.gdshader"
  fi
  i=$((i + 1))
done < "$1"
