---
name: TC Plant Prices
description: A horticultural colour chart for tissue-culture plant prices, one swatch-coded row per plant.
colors:
  card-stock: "#e6e7e2"
  card-face: "#f3f3ef"
  ink: "#1b1d1f"
  graphite: "#575c60"
  hairline: "#c4c6bf"
  hairline-soft: "#dcddd7"
  row-hover: "#eaeae5"
  stale-grey: "#62676b"
  price-up: "#b42318"
  price-down: "#1d7342"
  seller-ink-0: "#2b4687"
  seller-ink-1: "#873870"
  seller-ink-2: "#1b6870"
  seller-ink-3: "#4a4f53"
  card-stock-dark: "#1c1e1d"
  card-face-dark: "#242725"
  ink-dark: "#e8e8e3"
  graphite-dark: "#a3a8a4"
  hairline-dark: "#3b3f3c"
  hairline-soft-dark: "#2f3330"
  row-hover-dark: "#2a2d2b"
  stale-grey-dark: "#949994"
  price-up-dark: "#f2877b"
  price-down-dark: "#72cf92"
  seller-ink-0-dark: "#93abe3"
  seller-ink-1-dark: "#b7a4ec"
  seller-ink-2-dark: "#c8cbc5"
  seller-ink-3-dark: "#7f95c9"
  swatch-leaf-green: "#3d7a4a"
  swatch-albo: "#f2f1ea"
  swatch-aurea: "#e2bd2c"
  swatch-mint: "#a8d5b4"
  swatch-pink: "#e897b0"
  swatch-lava: "#d4572e"
  swatch-edge: "rgba(0, 0, 0, .22)"
  swatch-edge-dark: "rgba(255, 255, 255, .25)"
typography:
  headline:
    fontFamily: "Archivo, system-ui, Segoe UI, sans-serif"
    fontSize: "23px"
    fontWeight: 700
    lineHeight: 1.4
    letterSpacing: "-0.005em"
    fontVariation: "'wdth' 92"
  title:
    fontFamily: "Archivo, system-ui, Segoe UI, sans-serif"
    fontSize: "19px"
    fontWeight: 700
    lineHeight: 1.4
    fontVariation: "'wdth' 92"
  seller-name:
    fontFamily: "Archivo, system-ui, Segoe UI, sans-serif"
    fontSize: "14.5px"
    fontWeight: 700
    lineHeight: 1.4
  body:
    fontFamily: "Archivo, system-ui, Segoe UI, sans-serif"
    fontSize: "14px"
    fontWeight: 400
    lineHeight: 1.4
    fontFeature: "'tnum'"
  body-small:
    fontFamily: "Archivo, system-ui, Segoe UI, sans-serif"
    fontSize: "13px"
    fontWeight: 400
    lineHeight: 1.4
  annotation:
    fontFamily: "Archivo, system-ui, Segoe UI, sans-serif"
    fontSize: "11.5px"
    fontWeight: 400
    lineHeight: 1.4
    fontFeature: "'tnum'"
  label:
    fontFamily: "Archivo, system-ui, Segoe UI, sans-serif"
    fontSize: "11px"
    fontWeight: 600
    lineHeight: 1.4
    letterSpacing: "0.09em"
rounded:
  ink: "1px"
  swatch: "2px"
  control: "3px"
  dialog: "4px"
spacing:
  hair: "4px"
  xs: "6px"
  sm: "8px"
  md: "12px"
  gutter: "16px"
  section: "18px"
components:
  chip:
    backgroundColor: "{colors.card-face}"
    textColor: "{colors.ink}"
    rounded: "{rounded.control}"
    padding: "3px 9px 3px 3px"
  chip-selected:
    backgroundColor: "{colors.card-face}"
    textColor: "{colors.ink}"
    rounded: "{rounded.control}"
  field:
    backgroundColor: "{colors.card-face}"
    textColor: "{colors.ink}"
    rounded: "{rounded.control}"
    padding: "7px 10px"
  select:
    backgroundColor: "{colors.card-face}"
    textColor: "{colors.ink}"
    rounded: "{rounded.control}"
    padding: "7px 30px 7px 10px"
  button-outline:
    backgroundColor: "{colors.card-face}"
    textColor: "{colors.ink}"
    rounded: "{rounded.control}"
    padding: "4px 10px"
  button-text:
    textColor: "{colors.ink}"
    typography: "{typography.body}"
  swatch-strip:
    rounded: "{rounded.swatch}"
    width: "48px"
    height: "24px"
  seller-cell:
    backgroundColor: "{colors.card-face}"
    textColor: "{colors.ink}"
    padding: "10px 14px"
  table-header:
    backgroundColor: "{colors.card-face}"
    textColor: "{colors.graphite}"
    typography: "{typography.label}"
    padding: "7px 12px"
  table-cell:
    textColor: "{colors.ink}"
    typography: "{typography.body}"
    padding: "5px 12px"
  history-dialog:
    backgroundColor: "{colors.card-face}"
    textColor: "{colors.ink}"
    rounded: "{rounded.dialog}"
---

# Design System: TC Plant Prices

## Overview

**Creative North Star: "The Colour Chart Fan"**

The price table reads like a horticultural colour chart: matte card stock, near-black ink, hairline rules, and a painted swatch strip beside every plant. Variegation is what a tissue-culture buyer pays for, so the colour code is the one place the page spends saturated colour. Everything else is ink on card, dense enough that about a dozen plant rows (around 40px each) fit on a laptop screen.

The system is flat and printed rather than lit. There are no lifted cards, no big hero numbers, no tinted panels; structure comes from 1px hairlines and from the tablebox and seller strip sitting as lighter card faces on a slightly darker card stock. Dark mode is the same chart printed on charcoal card: the swatches keep their physical colours, everything else inverts to pale ink.

The build replaced a generic dark green-black dashboard with rounded stat cards and oversized percentages. That look is rejected.

**Key Characteristics:**
- Matte card stock and card face, with near-black ink and two hairline weights.
- Saturated colour only on variegation swatches; seller inks and the up/down pair are the only other hues, and they stay text-sized.
- One typeface, Archivo, with tabular figures everywhere and 11px uppercase tracked labels for codes and headers.
- Square corners (1–4px), no shadows, no elevation.
- Dense one-line rows on desktop; a pinned plant column with snap-scrolled seller columns on phones.

## Colors

Ink on matte card, with colour reserved for the physical swatch pigments and a few text-sized data inks.

### Primary
- **Swatch Pigments** (leaf green, albo, aurea, mint, pink, lava): the variegation colour codes painted into swatch strips and chip swatches. They are physical colours and are identical in light and dark mode. Leaf green always leads a strip; the variegation colours follow.

### Secondary
- **Seller Inks** (`seller-ink-0` to `seller-ink-3`, with dark-mode pairs): one ink per seller, assigned by seller index modulo four. Used only as a 4×14px ink bar beside the seller's name, the 3px top rule over that seller's table column, the history-table seller mark, and the seller's line in the history chart. Never a fill behind text.

### Tertiary
- **Price Up Red** and **Price Down Green** (`price-up`, `price-down`, with lighter dark-mode pairs): direction of a price change, always as text colour on a ▲ or ▼ figure, never as a background. Price Up Red also borders the load-error box.

### Neutral
- **Card Stock** (`card-stock`): the page background.
- **Card Face** (`card-face`): the surface for the table box, seller cells, filters, chips, and the history dialog.
- **Ink** (`ink`): text, the selected-chip outline, the cheapest-price underline, and the focus ring.
- **Graphite** (`graphite`): secondary text, labels, counts, headers, the drawn chevrons.
- **Hairline** (`hairline`): control borders, table box border, header bottom rule, the gaps between seller cells.
- **Soft Hairline** (`hairline-soft`): row dividers, column separators, chart grid lines.
- **Row Hover** (`row-hover`): the tint under a hovered table row.
- **Stale Grey** (`stale-grey`): older-list prices, always set in italic.

### Named Rules
**The Pigment Rule.** Saturated colour belongs to the swatches. Seller inks and the up/down pair are text-sized marks; no panel, badge or button is ever filled with colour.

**The Same Pigment Rule.** Swatch colours do not change with the theme. Only the swatch edge flips, from a 22% black edge on light card to a 25% white edge on dark card, so pale Albo still reads as a painted cell.

## Typography

**Display Font:** Archivo (variable width and weight, with system-ui and Segoe UI fallbacks)
**Body Font:** Archivo
**Label Font:** Archivo, uppercase and tracked

**Character:** A single grotesque used like a printed reference chart: bold and slightly condensed for titles, regular for plant names, and small tracked capitals for codes and column heads. Tabular figures are set on the body so every price column aligns.

### Hierarchy
- **Headline** (700, 23px, 92% width, -0.005em): the page title only.
- **Title** (700, 19px, 92% width): the plant name in the history dialog.
- **Seller Name** (700, 14.5px): seller names in the seller strip; the basket change beside it is 700 at 15px.
- **Body** (400, 14px, 1.4 line height, tabular figures): plant names, prices, table text.
- **Body Small** (400, 13px): subtitle, row count, filter checkbox labels; 12.5px for the footnote (max 75ch), seller-strip detail lines, and chip labels.
- **Annotation** (400, 11.5px): the price-change line, the bag-of-N line, the phone Cheapest seller name, chip counts. Drops to 11px in phone seller columns.
- **Label** (600, 11px, 0.09em, uppercase, Graphite): the genus and swatch code above each plant name (for example "Alocasia · ALB"), column headers, the "Variegation" field label, the dialog genus line.

### Named Rules
**The Code Label Rule.** The uppercase 11px label carries real data only: a genus, a swatch code, a column name, a field name. On phones its tracking tightens to 0.03em and it truncates with an ellipsis rather than wrapping.

**The Tabular Rule.** Every figure is tabular. Prices, percentages and counts align by digit in every column.

## Layout

A single centred column, max 1240px, with a 16px side gutter (22px top, 48px bottom). The order is fixed: header (title and list date on one baseline), filter bar, variegation chip fan, seller strip, row count, table, footnote. Vertical rhythm steps through 8, 10, 14, 16 and 18px; component internals use 4, 6, 8 and 12px.

The table is the page. Desktop rows are one line (5px vertical cell padding, about 40px tall), with the price change sitting inline after the price. Seller columns are at least 150px wide on desktop. Headers are sticky to the top of the scroll.

**Tablet and below (≤900px):** the seller strip stacks to one column; the table box scrolls sideways and the plant column is pinned on the left (min 210px), separated from the scroll by a 1px hairline; the price change and bag line drop under the price. The empty-state row stops behaving like a pinned plant cell (not sticky, no hover tint, left-aligned); instead its message stays pinned 12px from the left and no wider than the viewport minus 58px, so the text and its "Clear filters" link never scroll out of view.

**Phone (≤600px):**
- The pinned plant column narrows to 150px and its swatch strip turns vertical (22×30px, cells stacked).
- A phone-only **Cheapest** column (102px) appears beside it, showing the cheapest price, the seller(s), and the spread. When the winning price is a bag price (only possible when no seller offers a single plant), it carries the same Graphite "bag of 5 · €30" line as the seller columns. On wider screens the underline in the seller columns does this job instead.
- Seller columns are 92px. Sideways scrolling snaps (`scroll-snap-type: x mandatory`, scroll padding 150px), so a whole column always rests against the pinned column; the Spread column fills the remaining width so the end position also lands on a column edge.
- A 22px fade masks the right edge of the table box so a cut-off figure never reads as a real price; it is removed once the table is scrolled to its end.
- The chip fan wraps, with its "Variegation" label on its own line; chips tighten (20×20px swatch, 5px gap).
- Seller cells drop the basket-total line and keep the change, counts and cheapest share.

## Elevation & Depth

The system is flat. There are no drop shadows anywhere. Depth is tonal: a lighter card face sits on darker card stock, edged with a 1px hairline. The two box-shadows in the build are both hairlines: a 1px inset ring that thickens a selected chip's border, and a 1px right-edge rule on the pinned phone column. The history dialog is separated by a 50% near-black backdrop, not a shadow.

### Named Rules
**The Printed Card Rule.** Surfaces are printed, not lifted. Separation comes from a 1px hairline or a step from card stock to card face, never from a shadow or blur.

## Shapes

Square, near-printed corners: 1px on the seller ink bar, 2px on swatch strips, 3px on every control, chip, seller strip, and table box, 4px on the dialog. Borders are 1px throughout, with two exceptions: the 2px cheapest underline and the 3px seller-ink top rule over each seller column. The seller strip is drawn as a grid whose 1px gaps show the hairline colour through, so cells are divided by rules rather than spaced apart.

## Components

### Swatch Strip (signature)
A small painted colour chip, 48×24px, 2px corners, 1px swatch edge, cells side by side.
- **Cells:** leaf green first, then the variegation colours. One colour type gives green plus that colour twice; a pair (Albo/Pink, Mint/Pink) gives green plus both; Tricolor paints albo and pink.
- **Green only:** one leaf-green cell.
- **Unspecified variegation:** a diagonal hatch of albo and leaf green (3px and 2px stripes at 135°).
- **No colour type** (non-aroids not named variegated): an empty strip with a dashed hairline border.
- **Sizes:** 48×24 in the table, 26×22 in chips (20×20 on phones), 22×30 vertical in the phone table.

### Chips (variegation fan)
- **Style:** card face, 1px hairline border, 3px corners, 12.5px label; padding 3px 9px 3px 3px so the swatch sits flush on the left; a Graphite count follows the label.
- **Hover:** border darkens to Graphite.
- **Selected:** border goes to Ink plus a 1px inset Ink ring (a 2px ink outline). Selection is a toggle; one variegation at a time.
- **Fan:** chips wrap in a row with 6px gaps, led by a "Variegation" label.

### Inputs / Fields
- **Style:** card face, 1px hairline, 3px corners, 7px 10px padding, inherited 14px Archivo. Search grows (flex 1 1 260px); placeholders are Graphite.
- **Select:** native chrome removed; a drawn 10×6px chevron (the `--chev` image, stroked in Graphite and redrawn for dark mode) sits 11px from the right, with 30px right padding.
- **Checkboxes:** native, tinted Ink through `accent-color`, with 13px Graphite labels.
- **Focus:** a 2px solid Ink outline, 2px offset, on every input, select and button.

### Seller Strip
- **Structure:** one flat row of three cells (one per seller), stacking to one column at ≤900px. No stat cards.
- **Cell:** card face, 10px 14px padding. First line: ink bar and bold seller name on the left, the basket change (▲/▼ with %, bold 15px, in up/down colour) on the right. Below: a Graphite detail line with the euro totals for the same plants and the period, then ▲up ▼down =same counts, the cheapest share in bold Ink, and the latest-list count.

### Table
- **Header:** sticky, card face, 11px uppercase label in Graphite, 1px hairline bottom rule. Seller headers carry a 3px top rule in that seller's ink.
- **Sort:** the header text is a button. The active column shows a drawn 10×6px chevron, up for ascending and down for descending, stroked 1.5px in Graphite. It is never ▲/▼, which belong to price changes.
- **Rows:** 1px soft hairline dividers; seller and Spread columns are separated by soft vertical hairlines; Row Hover tint on hover; the whole row opens the history, and the plant name is a button so a row can be opened with Tab and Enter.
- **Plant cell:** swatch strip, then the genus and code label above the plant name.
- **Prices:** right-aligned tabular figures, whole euros when exact (€12), two decimals otherwise.

### State Encodings
- **Cheapest:** the cheapest current price is bold with a 2px Ink underline, shown only when at least two sellers currently list the plant.
- **Older-list price:** Stale Grey italic, with "last 3 Mar" or "not available" under it; it never counts as cheapest and sorts last.
- **Bag price:** shown per plant, with a Graphite line under it, "bag of 5 · €30". The same line, in the same wording, appears wherever a bag price is shown, including the phone Cheapest cell.
- **Price change:** ▲ in Price Up Red or ▼ in Price Down Green followed by the percentage (one decimal under 10%); "= same" or "new" in Graphite.
- **Spread:** "+N%" in Graphite, or in Price Up Red when above 25%.
- **Empty result:** a centred Graphite line with an underlined "Clear filters" text button, 32px vertical padding. At 900px and below it is left-aligned and held inside the visible part of the sideways-scrolling table (see Layout).

### History Panel
- **Container:** a modal dialog, card face, 1px hairline, 4px corners, up to 880px wide (viewport minus 32px), over a 50% near-black backdrop. Closes from a 1px-outlined "Close" button or a click on the backdrop.
- **Head:** the plant's swatch strip, the genus and code label, and the plant name in the Title style.
- **Chart:** 300px high stepped line chart, one line per seller in its seller ink, 2px lines with 3.5px points; Soft Hairline grid, Graphite ticks, month ticks, axis from €0; the legend uses 4×14px ink bars to match the seller strip.
- **Raw rows:** a bordered, scrollable table (max 260px, 13px text) of every original list row, newest first, each seller marked with its ink bar. Missing per-plant prices show a Stale Grey dash.

## Do's and Don'ts

### Do:
- **Do** give every plant a swatch strip, painted from its name, with leaf green leading.
- **Do** keep swatch pigments identical across themes and flip only the swatch edge.
- **Do** use seller inks only as marks: the 4×14px ink bar, the 3px column top rule, chart lines.
- **Do** mark the cheapest price with bold weight and a 2px Ink underline in place, not with a badge or fill.
- **Do** set older-list prices in Stale Grey italic so freshness is visible at a glance.
- **Do** draw sort direction as a stroked chevron, and keep ▲/▼ for price changes only.
- **Do** separate surfaces with 1px hairlines and card-face-on-card-stock steps.
- **Do** keep corners between 1px and 4px.
- **Do** on phones, pin the plant column, snap seller columns to whole-column positions, and fade the right edge until the end.

### Don't:
- **Don't** build a dark dashboard with rounded stat cards and giant percentages; that is the look this system replaced.
- **Don't** use drop shadows or blur for depth.
- **Don't** fill panels, badges or buttons with colour, and don't put a seller ink behind text.
- **Don't** set up/down red and green larger than the text they annotate.
- **Don't** leave native select chrome; use the drawn chevron.
- **Don't** let a price column end in a cut-off fragment on phones.
