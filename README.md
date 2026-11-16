# Redil: página de vendas do ebook

Página de vendas do guia "Ovinocultura de corte: guia prático do criador". HTML e CSS estáticos, sem build e sem dependência externa (fonte e imagens locais). Abra `index.html` no navegador.

- `index.html`: página de vendas (herói, números, amostras, para quem é, sumário, critérios, preço, perguntas, chamada final).
- `termos.html` e `privacidade.html`: páginas do rodapé.
- `estilo.css`: estilo único, com as cores e medidas do stylebook (`../redil-stylebook/DESIGN.md`).
- `img/`: capa, páginas de amostra do PDF, marca e imagem de compartilhamento.
- `fontes/`: Atkinson Hyperlegible Next em WOFF (OFL).
- `ferramentas/preparar_assets.sh`: copia marca e capa do stylebook e renderiza as páginas de amostra do PDF do ebook.

## Antes de publicar

1. **Link do checkout:** no fim do `index.html`, preencha `const CHECKOUT = "";` com o link da Greenn. Todos os botões de compra (classe `comprar`) passam a apontar para ele. Vazio, os botões levam ao bloco de preço.
2. **Preço:** R$ 47 aparece no herói, no bloco de preço e na chamada final. Se mudar (ex.: R$ 37 no lançamento), troque nos três.
3. **Domínio:** `redilovinos.com.br`, publicado pelo GitHub Pages a partir da branch `master` (arquivo `CNAME` na raiz). `canonical`, `og:url` e `og:image` já usam o endereço absoluto.
4. **Pixel ou analytics:** se entrar Meta Pixel, Google Analytics ou similar, atualize `privacidade.html` (hoje diz que a página não usa cookies).
5. Cadastre o endereço publicado como página de vendas do produto na Greenn (`../redil-stylebook/greenn/README.md`).

## Regenerar amostras

```
sh ferramentas/preparar_assets.sh
PAGINAS="13 33 53 75 110 122" sh ferramentas/preparar_assets.sh
```

Se o ebook mudar de paginação, confira os números de página nas legendas das amostras e no sumário do `index.html`.

Requisitos: `pdftoppm` (poppler), ImageMagick e Python 3 com `fonttools`.
