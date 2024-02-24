if [ "$#" -lt 3 ]; then
    echo "Usage: $0 <search_string> <replace_string> <file1> [<file2> ...]"
    exit 1
fi

search_string="$1"
replace_string="$2"
shift 2  #

for file in "$@"; do

    if [ ! -f "$file" ]; then
        echo "File not found: $file"
        continue
    fi

    sed -i "s/$search_string/$replace_string/g" "$file"

    echo "String '$search_string' replaced with '$replace_string' in $file"
done



