# Data Dictionary

## Raw Data

**File:** `raw_data/company_esg_financial_dataset.csv`
**Records:** 11,000 rows | **Columns:** 16

### Identifiers & Demographics

| Column | Type | Description |
|:---|:---|:---|
| `CompanyID` | Integer | Unique company identifier (1–1,000) |
| `CompanyName` | String | Company label (Company_1 through Company_1000) |
| `Industry` | String | Business sector — Technology, Finance, Healthcare, Energy, Manufacturing, Retail, Consumer Goods, Utilities, Transportation |
| `Region` | String | Geographic region — North America, Europe, Asia, Latin America, Africa, Middle East, Oceania |
| `Year` | Integer | Reporting year (2015–2025) |

### Financial Metrics

| Column | Type | Description |
|:---|:---|:---|
| `Revenue` | Float | Annual revenue (in millions) |
| `ProfitMargin` | Float | Profit margin as a percentage |
| `MarketCap` | Float | Market capitalization (in millions) |
| `GrowthRate` | Float | Year-over-year revenue growth (%). Null for each company's first year (2015) |

### ESG Scores

| Column | Type | Description |
|:---|:---|:---|
| `ESG_Overall` | Float | Composite ESG score (0–100) |
| `ESG_Environmental` | Float | Environmental pillar score (0–100) |
| `ESG_Social` | Float | Social pillar score (0–100) |
| `ESG_Governance` | Float | Governance pillar score (0–100) |

### Environmental Footprint

| Column | Type | Description |
|:---|:---|:---|
| `CarbonEmissions` | Float | Annual carbon emissions (tonnes) |
| `WaterUsage` | Float | Annual water consumption (cubic meters) |
| `EnergyConsumption` | Float | Annual energy usage (MWh) |

---

## Clean Data (SQL Output)

**File:** `clean_data/Cleaned_Sustainability_ESG.csv`
**Records:** 11,000 rows | **Columns:** 10

| Column | Type | Source | Description |
|:---|:---|:---|:---|
| `CompanyID` | Integer | Direct | Unique company identifier |
| `CompanyName` | String | Direct | Company label |
| `Industry` | String | Direct | Business sector |
| `Region` | String | Direct | Geographic region |
| `Revenue` | Float | Direct | Annual revenue (millions) |
| `Calculated_Profit` | Float | **Engineered** | `Revenue × (ProfitMargin / 100)` |
| `ESG_Overall` | Float | Direct | Composite ESG score |
| `Sustainability_Status` | String | **Engineered** | ESG tier classification (see below) |
| `CarbonEmissions` | Float | Direct | Annual carbon emissions (tonnes) |
| `Carbon_Intensity` | Float | **Engineered** | `CarbonEmissions / Revenue` — emissions per dollar earned |

### Sustainability Status Definitions

| Status | ESG Score Range | Count | Share |
|:---|:---|---:|---:|
| ESG_Leader | ≥ 70 | 1,930 | 17.5% |
| Average_Performer | 40 – 69 | 6,941 | 63.1% |
| High Risk / Laggard | < 40 | 2,129 | 19.4% |
