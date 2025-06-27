# ESP-OMZ-diapycnal-mixing-analysis
Code supporting the analysis of diapycnal mixing and oxygen transport in the Eastern South Pacific Oxygen Minimum Zone (ESP-OMZ)
# OMZ Mixing Analysis

The study focuses on how salt-finger-driven diapycnal mixing enhances vertical oxygen transport at the southern edge of the ESP-OMZ, off central Chile (~36.5°S). The analysis is based on glider and microstructure observations collected between 2020 and 2022.

## Repository Structure

- `X02_Processing_CTD.m` – CTD data pre-processing
- `X03_Processing_VMP.m` – VMP microstructure data handling
- `X04_Processing_ADCP.m` – ADCP current profile processing
- `X07_Processing_Glider.m` – Glider T/S/O₂ data processing
- `Figure_*.m` – MATLAB scripts to generate figures in the paper
- `Figures/` – Folder where figures are saved
- `ODAS/` – Placeholder (not included): requires proprietary ODAS software
- `data/` – Data not included; see "Data Access" section below

## Requirements

- MATLAB (R2020 or later recommended)
- Python 3.x (for some pre/post-processing notebooks)
- ODAS software suite (Rockland Scientific) for raw microstructure data processing — not included

## Data Access

The raw and processed datasets used in this study are available via Zenodo (DOI pending). Due to licensing restrictions, ODAS software must be obtained separately from Rockland Scientific.

## Dependencies & Acknowledgements

This repository makes use of several third-party tools and libraries:
- **ODAS Processing Software** – Used to process microstructure data collected with Rockland Scientific instruments  
  https://rocklandscientific.com/  
  Please cite: *Rockland Scientific International Inc. (2023). ODAS Processing Software, Version 5.4.1. Victoria, Canada.  
  Instruments and software provided under license from Rockland Scientific.

- **M_Map** – A mapping toolbox for MATLAB developed by Rich Pawlowicz  
  https://www.eoas.ubc.ca/~rich/map.html  
  Please cite: Pawlowicz, R. (2020). *M_Map: A Mapping package for MATLAB.*

- **GSW Oceanographic Toolbox (TEOS-10)** – For thermodynamic seawater calculations  
  http://www.teos-10.org  
  Please cite: IOC, SCOR, and IAPSO, 2010. *The international thermodynamic equation of seawater – 2010: Calculation and use of thermodynamic properties*. Intergovernmental Oceanographic Commission, Manuals and Guides No. 56.

- **cmocean colormaps** – Perceptually uniform colormaps for oceanography  
  https://matplotlib.org/cmocean/  
  Please cite: Thyng, K. M., Greene, C. A., Hetland, R. D., Zimmerle, H. M., & DiMarco, S. F. (2016). *True colors of oceanography: Guidelines for effective and accurate colormap selection*. Oceanography, 29(3), 9–13.

- **subplot1.m / subplot1c.m** – Advanced subplot layout function for MATLAB  
  Written by Eran O. Ofek (2002)  
  http://wise-obs.tau.ac.il/~eran/matlab.html

We thank the authors and maintainers of these packages for enabling open scientific analysis and reproducibility.

## License

This code is released under the [MIT License](LICENSE).

Note: ODAS-related scripts require proprietary software and are not covered by this license.

## Citation

To cite this repository, use the Zenodo DOI (pending). You may also cite the paper directly (DOI coming soon).
