ffmpeg -re -loop 1 -f image2 -framerate 1 -i ${BACKGROUND_IMAGE} -i ${STREAM_SOURCE} -s 1920x1080 -pix_fmt yuv420p -b:v 4500k -acodec aac -ar 48000 -aq 0 -filter:v "fps=25" -vcodec libx264 -tune stillimage -p
reset ultrafast -b:v 3000k -maxrate 3000k -bufsize 6000k -f flv -threads 2 rtmp://ingest.global-contribute.live-video.net/app/${STREAM_KEY}
