# 4x4 Bit Approximate Multiplier

This repository presents an approximation technique for a 4x4 bit multiplier based on the methods described in the paper [Design and Analysis of Approximate Multipliers](https://www.researchgate.net/publication/368293010). The final implementation satisfies the following criteria:
- **Mean relative error**: Less than 5%
- **Number of LUTs**: Less than 12

## Overview

### Approximation Techniques
#### Half Adder
The exact half adder is approximated as follows:
- **Exact Implementation**:
  - Sum = \( A \oplus B \)  
  - Carry = \( A \cdot B \)
- **Approximated Implementation**:
  - Sum = \( A \lor B \)  
  - Carry = \( A \cdot B \)

A schematic diagram of the approximated half adder will be added below:  
*Placeholder for schematic diagram of approximated half adder*

#### Truth Table Comparison
A comparison of the truth tables for the exact and approximate half adders will be added below:  
*Placeholder for truth table comparison (half adder)*

#### Full Adder
The exact full adder is approximated as follows:
- **Exact Implementation**:
  - Sum = \( A \oplus B \oplus C_{in} \)  
  - Carry = \( (A \cdot B) \lor (B \cdot C_{in}) \lor (C_{in} \cdot A) \)
- **Approximated Implementation**:
  - Sum = \( B \)  
  - Carry = \( A \)  
  - \( C_{in} \) is not used.

A schematic diagram of the approximated full adder will be added below:  
*Placeholder for schematic diagram of approximated full adder*

#### Truth Table Comparison
A comparison of the truth tables for the exact and approximate full adders will be added below:  
*Placeholder for truth table comparison (full adder)*

### Partial Product Transformation
The approximation involves the transformation of partial product terms \( a_{m,n} \) and \( a_{n,m} \) into propagate and generate terms:
- \( p_{m,n} = a_{m,n} \lor a_{n,m} \)
- \( g_{m,n} = a_{m,n} \cdot a_{n,m} \), where \( m \neq n \)
- \( a_{m,m} \) terms are retained.

Two images will be added to show the transformation process:  
*Placeholder for partial product transformation images*

### Partial Product Reduction with Compressors
A **compressor** is used to simplify the partial product tree. It takes 4 input bits and a carry-in (\( C_{in} \)) bit and generates Sum, Carry, and Carry-out (\( C_{out} \)) bits. The exact compressor uses two full adders:
1. The first full adder takes 3 input bits and generates:
   - Intermediate Sum
   - Carry-out (\( C_{out} \))
2. The second full adder takes:
   - Intermediate Sum
   - 4th input bit
   - Carry-in (\( C_{in} \))  
   and generates the final Sum and Carry bits.

A schematic diagram of the exact compressor will be added here:  
*Placeholder for schematic diagram of exact compressor*

#### Approximated Compressor
The approximated compressor is defined as:
- Carry = \( C_{in} \)
- Sum = \( (A \oplus B) \lor (C \oplus D) \)
- Carry-out (\( C_{out} \)) = \( (A \cdot B) \lor (C \cdot D) \)

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
