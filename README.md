# German Portuguese Keyboard Layout

This repository contains files that can be used to include a new variant to the German keyboard layout for Linux (or any other thing that use xkb for keyboard layout).

In the German standard layout, the tilde (~) is not a dead key and if you set it as dead key, it will still be hard to type due its position in the keyboard. Also, when typing syllables like "ção", it would be required key combinations for the dead key.

The variants proposed here makes the keys for umlaut, \<AC10\> and \<AC11\> (after <kbd>L</kbd>), respectively <kbd>Ä</kbd> and <kbd>Ö</kbd>, to type `ã` and `õ` when lowercase and `Ã` and `Õ` when uppercase. The letters with umlaut `ä`, `ö`, `Ä`, `Ö` can be typed by holding <kbd>Alt Gr</kbd> + <kbd>Ä</kbd>/<kbd>Ö</kbd>.

Optionally, I also supply a layout that changes the key \<AC02\> to type cedilla `ç` instead of `ß`, and set the <kbd>S</kbd> key to type `ß`. Check the `de-symbols-keep-eszett` file. Rename it to `de` if installing manually.

I left the <kbd>Z</kbd> in the middle of the keyboard because in portuguese the letter Z is used much more frequently than Y (rare).

### Advantages:

The rather frequent `ã` and `õ` letters are typed with a single hit (that is better the the Brazilian ABNT layout). As in the Brazilian ABNT Layout, you can have a dedicated key for `ç`. If choosing to keep the eszett, the `ç` can be obtained by accentuating the `c`.

---

Este repositório contém arquivos que podem ser usados para incluir uma nova variante do layout de teclado alemão para Linux (ou qualquer outra coisa que use xkb para layout de teclado) que ajuda a digitação em português.

No teclado padrão alemão, o til (~) não é uma tecla morta e se você escolher o layout com til morto, ainda é difícil de digitar devido à sua posição no teclado. Além disso, as frequentes sílabas como `ção` exigiriam uma combinação de teclas para a tecla morta.

As variantes propostas aqui fazem as teclas \<AC10\> e \<AC11\> (depois de <kbd>L</kbd>), respectivamente <kbd>Ä</kbd> e <kbd>Ö</kbd>, digitarem `ã` e `õ` quando em caixa baixa `Ã` e `Õ` quando em caixa alta. As letras com trema `ä`, `ö`, `Ä`, `Ö` podem ser digitadas com <kbd>Alt Gr</kbd> + <kbd>Ä</kbd>/<kbd>Ö</kbd>.

Opcionalmente eu também forneço um layout para a tecla\<AC02\> digitar `ç` ao invés de `ß`, e configura <kbd>S</kbd> para digitar `ß`. Cheque o arquivo `de-symbols-keep-eszett`. Renomeie-o para `de` se instalando manualmente.

Eu deixei o <kbd>Z</kbd> no meio do teclado pois em português a letra Z é muito mais comum que Y (raro).

### Vantagens:

As letras acentuadas frequentemente `ã` e `õ` são digitadas numa única teclada (melhor ainda que o teclado ABNT brasileiro) e assim como o ABNT brasileiro, o `Ç` pode ganhar uma tecla dedicada.

## Install / Instalação

### Automaticamente / Automatic

Baixe os arquivos e execute `install.sh`. O backup dos arquivos modificados é criado automaticamente.

Download the files and run `install.sh`. It creates backup automatically of the modifyed files.

```
chmod +x install.sh
./install.sh
```

Use a opção `-c` para substituir **ß** por **ç**.

Use the option `-c` to replace **ß** by **ç**.

To revert use the option `-r`.

Para reverter use `-r`.


```
./install.sh -r
```

For help and more options/ Para ajuda e mais opções:

```
./install.sh -h
```

### Manualmente / Manually

Cppy the folder `xkb` to

```
/usr/share/X11
```

allowing the replacement of files. I recommend backing up the files.

---

Copie a pasta `xkb` para

```
/usr/share/X11
```
permitindo a substituição dos arquivos. Recomendo criar backup dos arquivos que serão substituídos.

## Use the layout / Use o layout

After installing, reboot. The layout should appear in the options. On Gnome:

Settings > Region and Language > +

Após instalar, reinicie. O layout deve aparecer nas opções. No Gnome:

Configurações > Região e Linguagem > +

## References

1. [Make your own custom keyboard layout for Linux](https://ubuntu-mate.community/t/make-your-own-custom-keyboard-layout-for-linux/19733)
2. [Custom Keyboard in Linux/X11](http://people.uleth.ca/~daniel.odonnell/Blog/custom-keyboard-in-linuxx11#e)
