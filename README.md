# Astemity

Panel do Adobe Premiere Pro: easing keyframe'ow, wklejanie, emoji, grid,
napisy z mowy, auto-cut, zestawy efektow, pobieranie z YouTube.

W tym repozytorium sa **tylko gotowe wydania**. Kod panelu jest prywatny.

## Pobieranie

Wejdz w [Releases](../../releases/latest) i wez plik dla swojego systemu:

| System | Plik |
|---|---|
| Windows | `Astemity-X.Y.Z-instalator.exe` |
| macOS | `Astemity-X.Y.Z.dmg` |

Wymagane: Premiere Pro 22 lub nowszy.

## Instalacja na Windows

1. Uruchom pobrany `.exe`.
2. **Windows pokaze niebieskie okno "System Windows ochronil Twoj komputer".**
   To normalne: instalator nie ma platnego podpisu cyfrowego.
   Kliknij **Wiecej informacji**, potem **Uruchom mimo to**.
3. Przejdz kreator do konca.
4. Zamknij Premiere Pro calkowicie i odpal ponownie.
5. Okno > Rozszerzenia > Astemity

Instalator nie potrzebuje praw administratora. Wgrywa panel do
`%APPDATA%\Adobe\CEP\extensions` i wlacza tryb debug CEP, bez ktorego
Premiere nie wczyta niepodpisanego rozszerzenia.

## Instalacja na macOS

1. Otworz pobrany `.dmg`.
2. **Kliknij prawym przyciskiem** na `Zainstaluj Astemity.command` i wybierz
   **Otworz**. Zwykle dwuklikniecie system zablokuje - plik nie jest podpisany.
3. W oknie z ostrzezeniem kliknij **Otworz** jeszcze raz.
4. Poczekaj na napis "Zainstalowano w: ...".
5. Zamknij Premiere Pro calkowicie i odpal ponownie.
6. Okno > Rozszerzenia > Astemity

Gdyby macOS nie dal otworzyc pliku w ogole: Ustawienia systemowe >
Prywatnosc i ochrona > przewin na dol > przy komunikacie o zablokowanym
pliku kliknij **Otworz mimo to**, potem sprobuj ponownie.

## Dlaczego system ostrzega

Podpis cyfrowy to oplata roczna u Microsoftu i Apple. Panel jest robiony
dla siebie i kilku znajomych, wiec podpisu nie ma. Ostrzezenie mowi tylko
"nie wiem, kto to zrobil" - nie "znalazlem wirusa".

## Aktualizacje

Panel sam sprawdza nowa wersje przy starcie. Gdy jest nowsza, w menu >
Panel pojawia sie pasek **"Jest X.Y.Z - Aktualizuj"**: jeden klik pobiera
i podmienia pliki, drugi (**Przeladuj**) wczytuje nowa wersje bez restartu
Premiere. Instalator jest potrzebny tylko za pierwszym razem.

## Deinstalacja

- **Windows**: Ustawienia > Aplikacje > Astemity > Odinstaluj.
- **macOS**: `Odinstaluj Astemity.command` z obrazu DMG (tez prawym
  przyciskiem > Otworz).

Oba zapytaja, czy usunac takze Twoje ustawienia (zestawy efektow, presety
Grid). Domyslnie ustawienia **zostaja** - przydadza sie przy ponownej
instalacji. Klucz Groq z pliku `.env` lezy w folderze panelu i znika
razem z nim.
