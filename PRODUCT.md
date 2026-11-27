# Product

<!-- impeccable:product-schema 1 -->

## Platform

web

## Users

Primarily the owner: a tissue-culture (TC) plant buyer who orders lab-grown plants (mostly aroids such as Alocasia, Anthurium, Monstera and Philodendron, plus begonias and jewel orchids) from several sellers' periodic price lists. Secondary: friends and plant-group members the owner sends a link to, usually a filtered view (a genus, a seller, a sort) to answer a specific question. Viewers arrive on desktop and on phones.

## Product Purpose

Turn scattered seller price lists into one comparable overview, so a buyer can:

- decide **where to order a plant**: which seller is cheapest right now for a specific plant;
- see **whether prices are dropping**, per plant and per seller, to decide between buying now and waiting;
- judge **which seller to follow**: who is usually cheapest and who changes prices;
- **find new or rare plants**: what newly appeared on a list or is sold by only one seller.

Success: a question like "who sells Alocasia Simpo Albo cheapest, and is that price going down?" is answered in seconds, and the answer is trustworthy.

## Positioning

A price history that no single seller publishes: lists from different sellers, taken on different dates and written in different naming styles, are aligned into one record per plant. Plant names are normalised across sellers (e.g. "Var", "Variegata" and "variegated" become one name), prices are compared per plant, and every figure can be traced back to the original list row.

## Operating Context

- Price lists arrive as PDFs, screenshots and pre-order lists, roughly every one to two months per seller, on different dates per seller. Some come from private buying groups.
- The owner has the lists extracted into `prices.csv` (one row per plant, package and date), runs `check.ps1`, commits and pushes; GitHub Pages republishes the site within a minute or two.
- Viewers use the page as a lookup tool: search or filter, sort, open one plant's history, and share the URL of the current view.

## Capabilities and Constraints

- **Data:** `prices.csv` columns `Date` (dd-mm-yyyy), `Genus`, `Variety`, `Name` (supplier's original text, Yara only), `Package` ("N Plant/Bag"), `Price/Bag`, `Price/Plant`, `Supplier`. Prices are in euros, written "€ 12.34" or "not available".
- **Sellers today:** Yara, Tea & Sarah, 1Lab. Seller names and full price histories are public by the owner's choice.
- **Terminology:**
  - **Current price:** the price on that seller's most recent list.
  - **Older-list price:** a plant missing from the seller's latest list; it is never counted as cheapest.
  - **Bag price:** shown per plant ("bag of 5 · €30"); it only counts as cheapest when no seller offers a single plant.
  - **Price change (seller):** the total for the same plants on the seller's previous list against the latest one.
  - **Spread:** how much dearer the most expensive current seller is than the cheapest.
- **Naming conventions:** "Variegated" always comes last. For aroids, Albo, Aurea, Mint, Tricolor, Lava and Stardust imply "Variegated". Colour pairs are written "Albo/Pink" and "Mint/Pink". `normalize_names.ps1` holds the rules, and `name_mapping.csv` records the original clean-up.
- **Technical:**
  - a static site (`index.html` reads `prices.csv` in the browser), with no backend or accounts;
  - one dependency, Chart.js;
  - hosted on GitHub Pages from a public repository;
  - `serve.ps1` serves it for local preview.
- **Shareable views:** search, filters and sort are kept in the URL.
- **Open decisions:**
  - Shipping costs are not included in any comparison yet, although they can change which seller is cheapest.
  - No wish-list or basket total per seller yet.
  - No automatic warning for plant names that have never appeared before.
  - The open history panel isn't part of a shared link.

## Evidence on Hand

- `prices.csv`: 2,904 rows, 781 plants, lists dated 01-01-2026 to 25-11-2026 from three sellers.
- `name_mapping.csv`: 446 recorded old-to-new name changes.
- No testimonials, user counts or seller partnerships exist. Do not invent them.

## Product Principles

1. **Compare like with like.** Single plants against single plants, current lists against current lists, the same plants before and after. A number that mixes these misleads the buyer.
2. **Every figure is traceable.** Any price, change or "cheapest" label can be followed back to the raw list rows it came from.
3. **Say how fresh it is.** Dates and older-list status stay visible, because sellers publish on different schedules.
4. **Adding a list stays cheap.** One CSV, one check, one push; no step that makes monthly updates a chore.
5. **Answers are shareable.** Any view worth looking at can be sent as a link.
