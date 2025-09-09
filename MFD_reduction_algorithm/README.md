# MFD Reduction Toolbox

**Matrix Fraction Description Reduction and Minimal Realization for MATLAB**

## Overview

This toolbox provides advanced algorithms for:
- Matrix Fraction Description (MFD) reduction
- Row-reduced form computation
- Minimal state-space realization
- Coprime factorization
- MIMO system analysis

Developed as part of a Master's thesis in Control Systems Theory.

## Installation

### Method 1: Toolbox File (.mltbx)
1. Download `MFD_ReductionToolbox.mltbx`
2. Double-click the file
3. MATLAB will automatically install the toolbox

### Method 2: From MATLAB
```matlab
matlab.addons.install('MFD_ReductionToolbox.mltbx');
```

## Quick Start

```matlab
% Define a MIMO transfer function
syms s
H = [1/(s+1), s/(s^2+2*s+1); 2/(s+2), 1/(s+3)];

% Complete MFD reduction and minimal realization
[A, B, C, D_l, N_l] = mfd_reduction(H);

% The result: G(s) = C*(sI-A)^(-1)*B = D_l^(-1)*N_l
```

## Key Functions

| Function | Purpose |
|----------|---------|
| `mfd_reduction()` | Complete workflow: H(s) → (A,B,C) |
| `construct_row_reduced_left_MFD()` | Row-reduced left MFD |
| `calculate_minimal_realization()` | Minimal realization (A,B,C) |
| `calculate_row_reduced_form()` | Row reduction algorithm |
| `calculate_left_coprime_representation()` | Coprime factorization |

## Examples

Run these scripts to see the toolbox in action:
- `getting_started.m` - Basic usage examples
- `example_mimo_system.m` - Complete MIMO example with verification

## Requirements

- MATLAB R2016a or later
- Symbolic Math Toolbox

## Applications



## Theory Background

The toolbox implements algorithms from:
- Kailath, T. "Linear Systems" (1980)
- Fornasini, E. "Sistemi Multivariabili (cap 3)" (2011)
- Polderman, Willems "Introduction to Mathematical Systems Theory: A Behavioral Approach"

## Citation

If you use this toolbox in research, please cite:
```
[Nobili Lorenzo], "MFD Reduction Toolbox: Matrix Fraction Description 
Reduction and Minimal Realization," Master's Thesis, [University of Parma], 2025.
```

## License

This toolbox is distributed under the MIT License. See LICENSE file for details.

## Contact

For questions, bug reports, or feature requests:
- Email: [lorenzo.nobili@studenti.unipr.it]
- GitHub: [https://github.com/LolliN00/Tesi_magistrale]

## Version History

- **v1.0** (2025-09-09): Initial release
  - Complete MFD reduction pipeline
  - Row-reduced form algorithms  
  - Minimal realization computation