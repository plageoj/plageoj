#! /bin/bash

function removetag() {
    sed 's/<[^>]*>//g'
}

cat << EOH > dist/atom.xml
<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="/assets/atom.xsl"?>
<feed xmlns="http://www.w3.org/2005/Atom">
    <title>plageoj の最近の短歌</title>
    <link href="https://plageoj.me/atom.xml" rel="self"/>
    <updated>$(date -u +%Y-%m-%dT%H:%M:%SZ)</updated>
    <id>https://plageoj.me/</id>
    <author>
        <name>Masayuki Sugahara</name>
        <uri>https://plageoj.me</uri>
    </author>
EOH

file_index=$(wc -l < songs.txt)
line_number=1

while IFS= read -r line; do
    parsed_line=$(echo "$line" | removetag)
    updated_at=$(date -u -d @$(git blame -L $line_number,$line_number --porcelain songs.txt | grep '^author-time' | cut -d' ' -f2) +'%Y-%m-%dT%H:%M:%SZ')

    cat << EOE >> dist/atom.xml
    <entry>
        <title>${parsed_line} - plageoj</title>
        <link href="https://plageoj.me/${file_index}.html"/>
        <updated>${updated_at}</updated>
        <id>https://plageoj.me/${file_index}.html</id>
        <summary>${parsed_line}</summary>
    </entry>
EOE

    file_index=$((file_index - 1))
    line_number=$((line_number + 1))
done < songs.txt

echo "</feed>" >> dist/atom.xml
