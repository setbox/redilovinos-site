#!/bin/sh
set -e
RAIZ="$(cd "$(dirname "$0")/.." && pwd)"
STYLEBOOK="${STYLEBOOK:-$RAIZ/../redil-stylebook}"
EBOOK="${EBOOK:-$HOME/obsidian/setbox/academy/criacao-de-ovinos/produtos/ebook/ovinocultura-de-corte-ilustracoes-codex.pdf}"
PAGINAS="${PAGINAS:-13 33 53 75 110 122}"
IMG="$RAIZ/img"
mkdir -p "$IMG/amostras" "$IMG/marca" "$RAIZ/fontes"

cp "$STYLEBOOK/logo/redil-logo.svg" "$STYLEBOOK/logo/redil-logo-negativo.svg" "$STYLEBOOK/logo/redil-assinatura.svg" "$STYLEBOOK/logo/redil-favicon.svg" "$IMG/marca/"
cp "$STYLEBOOK/logo/png/favicon.ico" "$STYLEBOOK/logo/png/favicon-32.png" "$STYLEBOOK/logo/png/apple-touch-icon.png" "$STYLEBOOK/logo/png/icone-192.png" "$STYLEBOOK/logo/png/icone-512.png" "$IMG/marca/"
cp "$STYLEBOOK/greenn/imagens/divulgacao-1200x630.png" "$IMG/compartilhar.png"
magick "$STYLEBOOK/imagens/capa-ebook.png" -resize 900x -quality 86 "$IMG/capa.webp"
for nome in ovelha-cordeiro-mamando caderneta; do
  magick "$STYLEBOOK/imagens/$nome.png" -resize 900x -quality 86 "$IMG/$nome.webp"
done
python3 -c "from fontTools.ttLib import TTFont; f=TTFont('$STYLEBOOK/fontes/AtkinsonHyperlegibleNext[wght].ttf'); f.flavor='woff'; f.save('$RAIZ/fontes/atkinson-hyperlegible-next.woff')"
cp "$STYLEBOOK/fontes/OFL.txt" "$RAIZ/fontes/"

TMP="$(mktemp -d)"
for p in $PAGINAS; do
  pdftoppm -f "$p" -l "$p" -r 150 -png "$EBOOK" "$TMP/p"
  ARQ="$(ls "$TMP"/p-*.png)"
  magick "$ARQ" -quality 84 "$IMG/amostras/pagina-$p.webp"
  magick "$ARQ" -resize 440x -quality 82 "$IMG/amostras/pagina-$p-pequena.webp"
  rm "$ARQ"
done
rm -rf "$TMP"
echo "assets prontos em $IMG"
