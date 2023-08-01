####################################################Installing packages with the goal of having the same versions as UPPMAX module R_packages/4.2.1
# Declare initial sessioninfo
sessionInfo()

# Install remotes remotes_2.4.2, which is both the latest version as of 2023-08-01 and the latest version available on UPPMAX (module R_packages/4.2.1)
# Unlike devtools, remote does not have any dependencies.
# Therefore, remotes can be used to install a specific version of devtools and its dependencies.
remotes_url <- "https://github.com/r-lib/remotes/archive/refs/tags/v2.4.2.tar.gz"
install.packages(remotes_url, repos=NULL, type="source")
library("remotes")
sessionInfo()

# Install devtools 2.4.5, which is both the latest version as of 2023-08-01 and the latest version available on UPPMAX (module R_packages/4.2.1)
# R 4.2.1 and Rtools 42 is installed
remotes::install_version(
  package = "devtools",
  version = "2.4.5",
  upgrade = "never" # We are setting up an environment that should resemble UPPMAX module R_packages/4.2.1 as much as possible
)
unloadNamespace("remotes") # Unload remotes which we no longer need since we will be using devtools instead
library("devtools")
sessionInfo()

# Git vaccinate to minimize risk of accidental bad git pushes
git_vaccinate()

# Next installing specific package version to be as compatible with UPPMAX module R_packages/4.2.1 as possible

# Tidyverse 2.0.0
devtools::install_version("tidyverse", version = "2.0.0", repos = "https://ftp.acc.umu.se/mirror/CRAN/")

# plyr 1.8.8
devtools::install_version("plyr", version = "1.8.8", repos = "https://ftp.acc.umu.se/mirror/CRAN/")

# svglite 2.1.1
devtools::install_version("svglite", version = "2.1.1", repos = "https://ftp.acc.umu.se/mirror/CRAN/")

# writexl 1.4.2
devtools::install_version("writexl", version = "1.4.2", repos = "https://ftp.acc.umu.se/mirror/CRAN/")

# umap 0.2.10.0
devtools::install_version("umap", version = "0.2.10.0", repos = "https://ftp.acc.umu.se/mirror/CRAN/")

# SetRank 1.1.0
devtools::install_version("SetRank", version = "1.1.0", repos = "https://ftp.acc.umu.se/mirror/CRAN/")

# styler 1.10.0
devtools::install_version("styler", version = "1.10.0", repos = "https://ftp.acc.umu.se/mirror/CRAN/")

# grateful 0.2.0
devtools::install_version("grateful", version = "0.2.0", repos = "https://ftp.acc.umu.se/mirror/CRAN/")

# renv 0.17.3
devtools::install_version("renv", version = "0.17.3", repos = "https://ftp.acc.umu.se/mirror/CRAN/", )

# BiocManager 1.30.20
devtools::install_version("BiocManager", version = "1.30.20", repos = "https://ftp.acc.umu.se/mirror/CRAN/")
library("BiocManager")
sessionInfo()

# Bioconductor packages for release 3.16, using BiocManager seems easier than trying with devtools
options(timeout = 1000000) # Some packages are big and internet connection can be slow

BiocManager::install(version = "3.16", 
                     update = FALSE)

BiocManager::install(c("Rhtslib"), 
                     version = "3.16",
                     update = FALSE)

BiocManager::install(c("Rsamtools"), 
                     version = "3.16",
                     update = FALSE)

BiocManager::install(c("RSQLite"), 
                     version = "3.16",
                     update = FALSE)

BiocManager::install(c("annotate"), 
                     version = "3.16",
                     update = FALSE)

BiocManager::install(c("geneplotter"), 
                     version = "3.16",
                     update = FALSE)

BiocManager::install(c("rtracklayer"), 
                     version = "3.16",
                     update = FALSE)

BiocManager::install(c("DESeq2",
                       "IHW",
                       "tximport",
                       "tximportData",
                       "EnsDb.Mmusculus.v79",
                       "ensembldb",
                       "biomaRt",
                       "org.Mm.eg.db",
                       "reactome.db",
                       "GO.db",
                       "KEGGREST"), 
                     version = "3.16",
                     update = FALSE)

####################################################Unloading packages used for installation
unloadNamespace("devtools")
unloadNamespace("BiocManager")

####################################################Testing renv
# Load packages
lapply(
  c(
    "renv", # For project management
    "plyr", # Data wrangling, part of tidyverse but not automatically loaded with it. Always load plyr before dply to avoid known issues
    "tidyverse", # Data wrangling, processing and presentation
    "lubridate", # Working with dates, part of tidyverse but not automatically loaded with it
    "svglite", # To make svg files with ggsave
    "writexl", # Writing excel files
    "DESeq2", # Differential gene expression
    "IHW", # Better power for adjusting p-values of differential gene expression
    "tximport", # Importing RNAseq pipeline data
    "tximportData", # Importing RNAseq pipeline data
    "umap", # For umap, Uniform Manifold Approximation and Projection
    "EnsDb.Mmusculus.v79", # ensdb package for mouse
    "ensembldb", # For getting gene lengths necessary for TPM calculation
    "SetRank", # For the SetRank GSEA
    "biomaRt", # For annotation and GO gene sets
    "org.Mm.eg.db", # For GO term annotation, might be used instead of biomaRt
    "reactome.db", # For annotationdbi of reactome
    "GO.db", # For GO term annotation, might be used instead of biomaRt
    "KEGGREST", # For KEGG
    "styler", # R studio addin for interactively adhere to the tidyverse style guide
    "grateful" # For citing packages used
  ),
  library,
  character.only = TRUE
)

renv::init() # Get started with renv
y

# Reading vignette
vignette("renv")
