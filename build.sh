#! /bin/bash

if [ ! -d dist ]; then
  mkdir dist
fi

cp -r src/assets dist/

# Count total lines in songs.txt
total_lines=$(wc -l < songs.txt)

# Process each line in songs.txt and create a separate HTML file
line_number=1
while IFS= read -r line; do
  # Calculate previous and next page numbers
  prev=$((line_number - 1))
  next=$((line_number + 1))

  # Handle edge cases
  prev_link=""
  if [ $prev -ge 1 ]; then
    prev_link="<a href=\"$prev.html\" class=\"nav-link prev-link\"><ion-icon name=\"arrow-back\"></ion-icon></a>"
  fi

  next_link=""
  if [ $next -le $total_lines ]; then
    next_link="<a href=\"$next.html\" class=\"nav-link next-link\"><ion-icon name=\"arrow-forward\"></ion-icon></a>"
  fi

  # Replace placeholders in the template
  sed -e "s;%MAIN_CONTENT%;$line;g" \
      -e "s;%PREV_LINK%;$prev_link;g" \
      -e "s;%NEXT_LINK%;$next_link;g" \
      src/index.html > "dist/$line_number.html"

  line_number=$((line_number + 1))
done < songs.txt

echo "Processed $total_lines entries"
# Create index.html that redirects to the latest entry
cp dist/$total_lines.html dist/index.html
