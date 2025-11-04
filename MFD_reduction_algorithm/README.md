# MFD Reduction Toolbox

A comprehensive MATLAB toolbox for computing row-reduced left Matrix Fraction Descriptions (MFD) and minimal state-space realizations from rational transfer function matrices.

## Overview

This toolbox implements algorithms for:

- Converting rational transfer function matrices to row-reduced left MFD representations
- Computing minimal state-space realizations from MFD representations
- Verifying coprimeness and row-reducedness of polynomial matrices
- Applying polynomial differential operators to time-domain functions

The implementation follows classical control theory algorithms for polynomial matrix factorization and state-space realization, providing both symbolic and numerical computation capabilities.

## Features

- **Complete MFD Reduction Workflow**: One-function interface for converting transfer functions to minimal realizations
- **Row-Reduced Left MFD**: Constructs canonical row-reduced left factorizations
- **Minimal State-Space Realization**: Computes companion-form based minimal realizations
- **Left Coprime Factorization**: Converts right to left coprime representations using Hermite forms
- **Symbolic Computation**: Full support for symbolic polynomial matrices using MATLAB Symbolic Math Toolbox
- **Verification Tools**: Built-in functions to verify correctness of factorizations
- **Differential Operator Application**: Tools for applying polynomial operators to time-domain signals

## Installation

1. Clone or download this repository
2. Add the `src/` folder to your MATLAB path:
   ```matlab
   addpath('path/to/MFD_reduction_algorithm/src')
   ```
3. Ensure you have the MATLAB Symbolic Math Toolbox installed

## Quick Start

### Basic Usage

```matlab
% Define symbolic variable
syms s

% Define a transfer function matrix
H = [1/(s+1), s/(s^2+2*s+1);
     2/(s+2), 1/(s+3)];

% Compute MFD reduction and minimal realization
[A, B, C, D_l, N_l] = mfd_reduction(H);

% Display results
disp('Minimal Realization A matrix:');
disp(A);
disp('State-space dimension:');
disp(size(A,1));
```

### Step-by-Step Workflow

```matlab
syms s

% Define transfer function
H = [1/(s+1), 2/(s+2);
     3/(s+3), 4/(s+4)];

% Step 1: Construct row-reduced left MFD
[D_l, N_l, G] = construct_row_reduced_left_MFD(H);

% Step 2: Calculate minimal realization
[A, B, C] = calculate_minimal_realization(D_l, N_l);

% Step 3: Verify the result
G_reconstructed = compute_left_MFD(D_l, N_l);
compare_symbolic_matrices(simplify(G_reconstructed), simplify(H));
```

## Main Functions

### High-Level Functions

#### `mfd_reduction`

Complete MFD reduction and minimal realization workflow.

**Syntax:**

```matlab
[A, B, C, D_l, N_l] = mfd_reduction(H)
```

**Inputs:**

- `H` - Rational transfer function matrix (symbolic)

**Outputs:**

- `A`, `B`, `C` - Minimal state-space realization matrices
- `D_l` - Row-reduced left denominator polynomial matrix
- `N_l` - Corresponding left numerator polynomial matrix

---

#### `construct_row_reduced_left_MFD`

Constructs a row-reduced left MFD from a transfer function matrix.

**Syntax:**

```matlab
[D_l, N_l, G] = construct_row_reduced_left_MFD(H)
```

**Inputs:**

- `H` - Rational transfer function matrix (symbolic, must have full row rank)

**Outputs:**

- `D_l` - Row-reduced left denominator polynomial matrix
- `N_l` - Corresponding left numerator polynomial matrix
- `G` - Reconstructed transfer function G = D_l^(-1) \* N_l (should equal H)

**Algorithm:**

1. Clears denominators via LCM to obtain initial MFD
2. Computes left coprime factorization
3. Row-reduces the denominator matrix
4. Applies same transformation to numerator
5. Verifies correctness by comparing G with H

---

#### `calculate_minimal_realization`

Computes minimal state-space realization from left MFD.

**Syntax:**

```matlab
[A, B, C] = calculate_minimal_realization(D_l, N_l)
```

**Inputs:**

- `D_l` - Left denominator polynomial matrix (symbolic)
- `N_l` - Left numerator polynomial matrix (symbolic)

**Outputs:**

- `A` - State matrix of minimal realization
- `B` - Input matrix of minimal realization
- `C` - Output matrix of minimal realization

**Algorithm:**
Based on companion form construction:

- A = A_0 - P_lr _ P_hr^(-1) _ C_0
- B = Q_lr
- C = P_hr^(-1) \* C_0

where P_hr is the leading row coefficient matrix, P_lr contains lower coefficients, and A_0, C_0 are companion-form matrices.

---

### MFD Construction Functions

#### `calculate_lcm_and_initial_MFD`

Computes initial MFD by clearing denominators.

**Syntax:**

```matlab
[N_initial, result_lcm, D_initial] = calculate_lcm_and_initial_MFD(M)
```

---

#### `calculate_left_coprime_rapresentation`

Converts right coprime factorization to left coprime factorization.

**Syntax:**

```matlab
[D_cop, N_cop, G] = calculate_left_coprime_rapresentation(D_r, N_r)
```

Uses Hermite normal form to compute the conversion from G = N_r _ D_r^(-1) to G = D_cop^(-1) _ N_cop.

---

#### `calculate_row_reduced_form`

Computes row-reduced form of a polynomial matrix.

**Syntax:**

```matlab
[U, M_rr] = calculate_row_reduced_form(M)
```

**Outputs:**

- `U` - Unimodular transformation matrix such that M_rr = U \* M
- `M_rr` - Row-reduced form of M

Uses recursive algorithm with elementary unimodular transformations to achieve row-reducedness (leading coefficient matrix has full rank).

---

### Utility Functions

#### `compute_left_MFD`

Computes transfer function from left MFD representation.

```matlab
M = compute_left_MFD(D_l, N_l)
```

Computes M(s) = D_l^(-1) \* N_l.

---

#### `calculate_pole_polynomial`

Computes the pole polynomial of a transfer function matrix.

```matlab
pole_poly = calculate_pole_polynomial(H)
```

Returns the characteristic polynomial whose roots are the system poles.

---

#### `calculate_row_deg_vector`

Calculates the row degree vector of a polynomial matrix.

```matlab
l = calculate_row_deg_vector(M)
```

Returns a vector where l(i) is the degree of the i-th row.

---

#### `calculate_leading_row_matrix`

Extracts the leading row coefficient matrix.

```matlab
M_hr = calculate_leading_row_matrix(M)
```

Returns the matrix formed by the highest-degree coefficients of each row.

---

#### `calculate_vector_degree`

Computes the degree of a polynomial vector.

```matlab
deg = calculate_vector_degree(v)
```

Returns the maximum degree among all elements in vector v.

---

#### `compare_symbolic_matrices`

Compares two symbolic matrices element-wise for equality.

```matlab
compare_symbolic_matrices(M1, M2)
```

Prints whether the matrices are identical after simplification.

---

#### `print_polynomial`

Displays a polynomial in human-readable form.

```matlab
print_polynomial(p)
```

---

#### `print_factorized`

Displays a polynomial in factorized form.

```matlab
print_factorized(p)
```

---

### Companion Form Construction

#### `build_A0`

Constructs companion-form A_0 matrix from row degree vector.

```matlab
A_0 = build_A0(l)
```

---

#### `build_C0`

Constructs companion-form C_0 matrix from row degree vector.

```matlab
C_0 = build_C0(l)
```

---

#### `build_Plr`

Builds P_lr matrix (lower row coefficients) from denominator matrix.

```matlab
P_lr = build_Plr(D_l, l)
```

---

#### `build_Qlr`

Builds Q_lr matrix (lower row coefficients) from numerator matrix.

```matlab
Q_lr = build_Qlr(N_l, l)
```

---

#### `build_S_matrix`

Constructs selection matrix S.

```matlab
S = build_S_matrix(l)
```

---

#### `build_Gamma_matrix`

Constructs Gamma matrix for companion form.

```matlab
Gamma = build_Gamma_matrix(l)
```

---

### Differential Operator Tools

#### `D_operator`

Applies polynomial operator by substituting s → d/dt.

**Syntax:**

```matlab
out = D_operator(Ms, f, t, s)
```

**Inputs:**

- `Ms` - Symbolic m×n matrix of polynomials in s (Laplace domain)
- `f` - Symbolic n×1 vector of time-domain functions
- `t` - Symbolic time variable
- `s` - Symbolic Laplace variable

**Output:**

- `out` - m×1 vector where each element is the result of applying the differential operator

**Example:**

```matlab
syms s t
Ms = [s^2 + 2*s + 1, s];
f = [sin(t); cos(t)];
out = D_operator(Ms, f, t, s);
% Computes: d²sin(t)/dt² + 2*d sin(t)/dt + sin(t) + d cos(t)/dt
```

---

### Advanced Functions

#### `MNsmithForm`

Computes Smith normal form of polynomial matrices of any size.

**Syntax:**

```matlab
[SA, invFact, D] = MNsmithForm(A)
```

**Outputs:**

- `SA` - Smith normal form of A
- `invFact` - Vector of invariant factors
- `D` - Vector of GCDs of all non-zero i-th order minors

Credit: 2016 by Kristof Pucejdl, CTU in Prague

---

#### `piazzi_visioli_polynomial`

Constructs special polynomials for trajectory planning.

```matlab
poly = piazzi_visioli_polynomial(...)
```

---

## Algorithm Overview

### MFD Reduction Algorithm

The complete reduction follows these steps:

1. **Initial MFD Construction**

   - Compute LCM of all denominators
   - Create diagonal denominator matrix D_initial = LCM \* I
   - Compute polynomial numerator N_initial = H \* LCM

2. **Left Coprime Factorization**

   - Form stacked matrix [D_initial; N_initial]
   - Compute Hermite normal form with unimodular transformation U
   - Extract left coprime factors from bottom blocks of U

3. **Row Reduction**

   - Recursively apply elementary unimodular transformations
   - Ensure leading coefficient matrix has full rank
   - Track cumulative transformation U

4. **Minimal Realization**
   - Compute row degree vector l
   - Build companion matrices A_0 and C_0
   - Extract coefficient matrices P_hr, P_lr, Q_lr
   - Form minimal realization using standard formulas

### Theoretical Background

The toolbox implements algorithms from:

- Polynomial matrix theory
- Left coprime factorization via Hermite forms
- Row-reduced forms and leading coefficient matrices
- Companion-form state-space realizations
- McMillan degree and minimality conditions

## Requirements

- MATLAB R2016b or later
- Symbolic Math Toolbox
- Control System Toolbox (optional, for additional verification)

## Examples

See the `examples/` directory for complete usage examples:

- `quadtank.mlx` - Quadruple tank system example with control design
- `prova.mlx` - Basic demonstration of MFD reduction workflow

## Project Structure

```
MFD_reduction_algorithm/
├── src/                          # Main source code
│   ├── mfd_reduction.m          # Main entry point
│   ├── construct_row_reduced_left_MFD.m
│   ├── calculate_minimal_realization.m
│   ├── calculate_left_coprime_rapresentation.m
│   ├── calculate_row_reduced_form.m
│   ├── calculate_lcm_and_initial_MFD.m
│   ├── compute_left_MFD.m
│   ├── calculate_pole_polynomial.m
│   ├── calculate_row_deg_vector.m
│   ├── calculate_leading_row_matrix.m
│   ├── calculate_vector_degree.m
│   ├── build_A0.m               # Companion form construction
│   ├── build_C0.m
│   ├── build_Plr.m
│   ├── build_Qlr.m
│   ├── build_S_matrix.m
│   ├── build_Gamma_matrix.m
│   ├── D_operator.m             # Differential operator tool
│   ├── MNsmithForm.m            # Smith normal form
│   ├── compare_symbolic_matrices.m
│   ├── print_polynomial.m
│   ├── print_factorized.m
│   └── piazzi_visioli_polynomial.m
├── examples/                     # Usage examples
│   ├── quadtank.mlx
│   └── prova.mlx
└── README.md                     # This file
```

## Common Use Cases

### 1. Model Order Reduction

```matlab
% Given a high-order transfer function, compute minimal realization
syms s
H = ... % Your transfer function
[A, B, C] = mfd_reduction(H);
fprintf('Reduced order: %d\n', size(A,1));
```

### 2. Controller Design

```matlab
% Obtain state-space form for modern control design
[A, B, C, D_l, N_l] = mfd_reduction(plant_tf);
% Now use A, B, C for LQR, pole placement, etc.
```

## Troubleshooting

### Common Issues

1. **Matrix not full row rank**

   - Error: "The input matrix must have full row rank"
   - Solution: Check that your transfer function matrix has independent rows

2. **Symbolic simplification takes too long**

   - Try using `simplify(..., 'Steps', 10)` for faster but less thorough simplification
   - Use numeric computation for large systems

3. **Memory issues with large matrices**
   - Consider reducing symbolic complexity before calling MFD functions
   - Use numeric approximations where possible

## Contributing

Contributions are welcome! Please ensure:

- All functions have proper documentation headers
- New algorithms include references to source papers/books
- Examples demonstrate new functionality

## Citation

If you use this toolbox in your research, please cite:

```bibtex
@software{mfd_reduction_toolbox,
  title = {MFD Reduction Toolbox},
  author = {Lorenzo Nobili},
  year = {2025},
  url = {https://github.com/LolliN00/Tesi_magistrale/tree/main/MFD_reduction_algorithm}
}
```

## License

MIT

## References

1. Kailath, T. (1980). _Linear Systems_. Prentice-Hall.
2. Fornasini,E. (2011). _Sistemi Multivariabili: Capitolo 3: Matrici Polinomiali_
3. Pucejdl, K. (2016). Smith Normal Form Implementation. CTU Prague.

## Contact

For questions, issues, or suggestions, please open an issue on GitHub or contact lorenzo.nobili@studenti.unipr.it

---

**Last Updated:** November 2025
