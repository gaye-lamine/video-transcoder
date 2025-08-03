INPUT_FILE="/input/video.mp4"
FILENAME=$(basename "$INPUT_FILE" .mp4)
OUTPUT_DIR="/output"
RESOLUTIONS=("1080" "720" "480")

echo "🎬 Transcodage de $INPUT_FILE..."

for RES in "${RESOLUTIONS[@]}"; do
    echo "➡️  ${RES}p..."
    ffmpeg -y -i "$INPUT_FILE" \
        -vf "scale=-2:$RES" \
        -c:v libx264 -preset fast -crf 23 \
        -c:a aac -b:a 128k \
        "$OUTPUT_DIR/${FILENAME}_${RES}p.mp4"
done

echo "✅ Transcodage terminé."

: "${AWS_ACCESS_KEY_ID?}"
: "${AWS_SECRET_ACCESS_KEY?}"
: "${S3_BUCKET?}"
: "${S3_ENDPOINT_URL?}"

echo "📤 Envoi sur S3 ($S3_BUCKET)..."

for RES in "${RESOLUTIONS[@]}"; do
    FILE="${OUTPUT_DIR}/${FILENAME}_${RES}p.mp4"
    aws s3 cp "$FILE" "s3://$S3_BUCKET/$FILENAME/" --endpoint-url "$S3_ENDPOINT_URL"
done

echo "🚀 Fini. Les vidéos sont en ligne."
