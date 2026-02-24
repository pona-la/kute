prev=""
while true
do
    #song=`curl -s http://localhost:8000/status-json.xsl | jq -r .icestats.source.title`
    json=`ffprobe -loglevel error -show_entries stream_tags:format_tags -of json https://kute.pona.la/stream/tpr`
    title=`echo $json | jq -r .streams[0].tags.title`
    artist=`echo $json | jq -r .streams[0].tags.artist`
    song=`echo "$artist - $title"`

    if [[ $song == $prev ]] ; then
        echo -n .
    elif [[ $song == "null" ]] ; then
        echo
        echo "No metadata detected. Resetting image."
        cp tpr.png new.png
        mv new.png current.png
        echo -n "Listening ..."
    else 
        echo
        echo "Generating label for song: $song"
        convert tpr.png -fill white -font "DejaVu-Sans" -pointsize 42 -gravity SouthWest -annotate +200+30 "$song" new.png
        mv new.png current.png
        echo -n "Listening ..."
    fi
    prev="$song"
done
