# 4x4 Bit Approximate Multiplier

This repository presents an approximation technique for a 4x4 bit multiplier based on the methods described in the paper [Design and Analysis of Approximate Multipliers](https://www.researchgate.net/publication/368293010). The final implementation satisfies the following criteria:
- **Mean relative error**: Less than 5%
- **Number of LUTs**: Less than 12

## Overview

### Approximation Techniques
#### Half Adder
The exact half adder is approximated as follows:
- **Exact Implementation**:
  - Sum = A $\oplus$ B 
  - Carry = A $\cdot$ B
- **Approximated Implementation**:
  - Sum = A $+$ B
  - Carry = A $\cdot$ B

A schematic diagram of the approximated half adder will be added below:  
*Placeholder for schematic diagram of approximated half adder*

#### Truth Table Comparison
A comparison of the truth tables for the exact and approximate half adders will be added below:  
*Placeholder for truth table comparison (half adder)*

#### Full Adder
The exact full adder is approximated as follows:
- **Exact Implementation**:
  - Sum = A $\oplus$ B $\oplus$ C<sub>in</sub>
  - Carry = (A $\cdot$ B) $+$ (B $\cdot$ C<sub>in</sub>) $+$ (C<sub>in</sub> $\cdot$ A)
- **Approximated Implementation**:
  - Sum = B  
  - Carry = A 
  - C<sub>in</sub> is not used.

A schematic diagram of the approximated full adder will be added below:  
*Placeholder for schematic diagram of approximated full adder*

#### Truth Table Comparison
A comparison of the truth tables for the exact and approximate full adders will be added below:  
*Placeholder for truth table comparison (full adder)*

### Partial Product Transformation
The approximation involves the transformation of partial product terms a<sub>m,n</sub> and a<sub>n,m</sub> ( a<sub>m,n</sub> = a[m] $\times$ b[n] ) into propagate and generate terms:
- p<sub>m,n</sub> = a<sub>m,n</sub> $+$ a<sub>n,m</sub>
- g<sub>m,n</sub> = a<sub>m,n</sub> $\cdot$ a<sub>n,m</sub>
- a<sub>m,m</sub> terms are retained.

Two images will be added to show the transformation process:  
*Placeholder for partial product transformation images*

### Partial Product Reduction with Compressors
A **compressor** is used to simplify the partial product tree. It takes 4 input bits and a carry-in (C<sub>in</sub>) bit and generates Sum, Carry, and Carry-out (C<sub>out</sub>) bits. The exact compressor uses two full adders:
1. The first full adder takes 3 input bits and generates:
   - Intermediate Sum
   - Carry-out (C<sub>out</sub>)
2. The second full adder takes:
   - Intermediate Sum
   - 4th input bit
   - Carry-in (C<sub>in</sub>)  
   and generates the final Sum and Carry bits.

A schematic diagram of the exact compressor will be added here:  
*Placeholder for schematic diagram of exact compressor*

#### Approximated Compressor
The approximated compressor is defined as:
- Carry = C<sub>in</sub>
- Sum = (A $\oplus$ B) $+$ (C $\oplus$ D)
- Carry-out (C<sub>out</sub>) = (A $\cdot$ B) $+$ (C $\cdot$ D)

A schematic diagram of the approximated compressor will be added here:  
*Placeholder for schematic diagram of approximated compressor*

#### Truth Table Comparison
A table comparing the truth tables of the exact and approximate compressors will be added below:  
*Placeholder for truth table comparison (compressor)*

### Final Summation
After the partial product reduction, the remaining Sum and Carry-out bits are processed using half adders and full adders to generate the final output.

---

## Results and Analysis
The following images demonstrate that the design meets the specified criteria for:
1. **Error**: Mean relative error less than 5%
2. **Power Utilization**: Efficient power usage
3. **LUT Utilization**: Number of LUTs less than 12

*Placeholder for images showing error, power, and utilization analysis*

---

Feel free to clone this repository and explore the implementation!
