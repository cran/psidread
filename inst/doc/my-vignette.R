## ----eval = FALSE-------------------------------------------------------------
#  devtools::install_github(repo = "Qcrates/psidread")

## -----------------------------------------------------------------------------
library(DiagrammeR)
library(psidread)

## ----echo=FALSE, fig.width=10, fig.height=10----------------------------------
DiagrammeR("
graph TB;
    A[Dataset Downloaded] --> B[psid_str, 3];
    B --> C{Type};
    C --> |Packaged| D{.rda files prepared?};
    C --> |Single| E{.rda files prepared?};
    D --> |No| F[psid_unzip, 4.1];
    D --> |Yes| G[psid_read, 5.1];
    F --> G;
    E --> |No| H[psid_unzip, 4.2];
    E --> |Yes| I[psid_read, 5.2];
    H --> I;
    G --> J[psid_reshape, 6];
    I --> J;
    J --> L((Output));
    
    style A fill:#ffffff,stroke:#4d4d4d,stroke-width:1px;
    style B fill:#ffffff,stroke:#4d4d4d,stroke-width:1px;
    style C fill:#ffffff,stroke:#4d4d4d,stroke-width:1px;
    style D fill:#ffffff,stroke:#4d4d4d,stroke-width:1px;
    style E fill:#ffffff,stroke:#4d4d4d,stroke-width:1px;
    style F fill:#ffffff,stroke:#4d4d4d,stroke-width:1px;
    style G fill:#ffffff,stroke:#4d4d4d,stroke-width:1px;
    style H fill:#ffffff,stroke:#4d4d4d,stroke-width:1px;
    style I fill:#ffffff,stroke:#4d4d4d,stroke-width:1px;
    style J fill:#ffffff,stroke:#4d4d4d,stroke-width:1px;
    style L fill:#ffffff,stroke:#4d4d4d,stroke-width:1px;
")

## -----------------------------------------------------------------------------
psid_str(
  varlist = c("hh_educ || [13]ER58223 [15]ER65459 [17]ER71538 [19]ER77599",
              "num_child || [13]ER53020 [15]ER60021 [17]ER66021 [19]ER72021"),
  type = "separated"
)

## -----------------------------------------------------------------------------
psid_varlist <- "|| religion_hh /// Household head's religious preference
	[97]ER11895 [99]ER15977 [01]ER20038 [03]ER23474 [05]ER27442 [07]ER40614 ///
	|| denom_hh /// Household head's religious denominations
	[97]ER11896 [99]ER15978 [03]ER23475 [05]ER27443 [07]ER40615 ///"
psid_str(
  varlist = psid_varlist,
  type = "integrated"
)

## -----------------------------------------------------------------------------
input_directory <- system.file(package = "psidread","extdata")
output_directory <- tempdir()
psid_unzip(indir = input_directory,
           exdir = output_directory,
           zipped = TRUE,
           type = "package",
           filename = NA)

## -----------------------------------------------------------------------------
psid_unzip(indir = input_directory,
           exdir = output_directory,
           zipped = FALSE,
           type = "package",
           filename = NA)

## -----------------------------------------------------------------------------
psid_unzip(indir = input_directory,
           exdir = output_directory,
           zipped = TRUE,
           type = "single",
           filename = "J327825.zip")

## -----------------------------------------------------------------------------
psid_varlist = c(" hh_age || [13]ER53017 [17]ER66017", " p_age || [13]ER34204")
str_df <- psid_str(varlist = psid_varlist, type = "separated")
input_directory <- system.file(package = "psidread","extdata")
psid_df <- psid_read(indir = input_directory, str_df = str_df,idvars = c("ER30000"),type = "package",filename = NA)
str(psid_df)

## -----------------------------------------------------------------------------
psid_df <- psid_read(indir = input_directory, str_df = str_df,idvars = c("ER30000"),type = "single",filename = "J327825")
str(psid_df)

## -----------------------------------------------------------------------------
df <- psid_reshape(psid_df = psid_df, str_df = str_df, shape = "long", level = "individual")
df

## -----------------------------------------------------------------------------
df <- psid_reshape(psid_df = psid_df, str_df = str_df, shape = "wide", level = "individual")
df

## -----------------------------------------------------------------------------
df <- psid_reshape(psid_df = psid_df, str_df = str_df, shape = "long", level = "household")
df

