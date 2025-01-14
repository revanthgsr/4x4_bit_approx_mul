# 4x4 Bit Approximate Multiplier

This repository presents an approximation technique for a 4x4 bit multiplier based on the methods described in the paper [Design and Analysis of Approximate Multipliers](https://www.researchgate.net/publication/368293010). The final implementation satisfies the following criteria:
- **Mean relative error**: Less than 10%
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

![ha](https://github.com/user-attachments/assets/c5b4fb62-f743-48f6-a240-dcc7a9935ff2)

#### Truth Table Comparison

<table>
  <thead>
    <tr>
      <th rowspan="2">A</th>
      <th rowspan="2">B</th>
      <th colspan="2">Exact</th>
      <th colspan="2">Approximate</th>
    </tr>
    <tr>
      <th>Sum</th>
      <th>Carry</th>
      <th>Sum</th>
      <th>Carry</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>1</td>
      <td>1</td>
      <td>0</td>
      <td>1</td>
      <td>1</td>
      <td>1</td>
    </tr>
  </tbody>
</table>

1 out of 4 cases has an error in Sum.

#### Full Adder
The exact full adder is approximated as follows:
- **Exact Implementation**:
  - Sum = A $\oplus$ B $\oplus$ C<sub>in</sub>
  - Carry = (A $\cdot$ B) $+$ (B $\cdot$ C<sub>in</sub>) $+$ (C<sub>in</sub> $\cdot$ A)
- **Approximated Implementation**:
  - Sum = B  
  - Carry = A 
  - C<sub>in</sub> is not used.

![fa](https://github.com/user-attachments/assets/32cd7a57-b511-4714-9b86-7a07927bb231)

#### Truth Table Comparison

<table>
  <thead>
    <tr>
      <th rowspan="2">A</th>
      <th rowspan="2">B</th>
      <th rowspan="2">C<sub>in</sub></th>
      <th colspan="2">Exact</th>
      <th colspan="2">Approximate</th>
    </tr>
    <tr>
      <th>Sum</th>
      <th>Carry</th>
      <th>Sum</th>
      <th>Carry</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>0</td>
      <td>0</td>
      <td>1</td>
      <td>1</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
    </tr>
    <tr>
      <td>0</td>
      <td>1</td>
      <td>1</td>
      <td>0</td>
      <td>1</td>
      <td>1</td>
      <td>0</td>
    </tr>
    <tr>
      <td>1</td>
      <td>0</td>
      <td>0</td>
      <td>1</td>
      <td>0</td>
      <td>0</td>
      <td>1</td>
    </tr>
    <tr>
      <td>1</td>
      <td>1</td>
      <td>0</td>
      <td>0</td>
      <td>1</td>
      <td>1</td>
      <td>1</td>
    </tr>
  </tbody>
</table>

4 out of 8 cases have errors: 4 in Sum and 2 in Carry

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

![exact_compressor](https://github.com/user-attachments/assets/c901f28d-e662-4ff3-ab1b-0521130129ee)

#### Approximated Compressor
The approximated compressor is defined as:
- Carry = C<sub>in</sub>
- Sum = (A $\oplus$ B) $+$ (C $\oplus$ D)
- Carry-out (C<sub>out</sub>) = (A $\cdot$ B) $+$ (C $\cdot$ D)

![compressor](https://github.com/user-attachments/assets/6d6a0eb8-3640-4ff0-b89c-5ea95ca5d910)

#### Truth Table Comparison

<table>
  <thead>
    <tr>
      <th rowspan="2">A</th>
      <th rowspan="2">B</th>
      <th rowspan="2">C</th>
      <th rowspan="2">D</th>
      <th rowspan="2">C<sub>in</sub></th>
      <th colspan="3">Exact</th>
      <th colspan="3">Approximate</th>
    </tr>
    <tr>
      <th>Sum</th>
      <th>Carry</th>
      <th>C<sub>out</sub></th>
      <th>Sum</th>
      <th>Carry</th>      
      <th>C<sub>out</sub></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>0</td><td>0</td><td>0</td><td>0</td><td>1</td>
      <td>1</td><td>0</td><td>0</td>
      <td>0</td><td>1</td><td>0</td>
    </tr>
    <tr>
      <td>0</td><td>0</td><td>0</td><td>1</td><td>1</td>
      <td>0</td><td>1</td><td>0</td>
      <td>1</td><td>1</td><td>0</td>
    </tr>
    <tr>
      <td>0</td><td>0</td><td>1</td><td>0</td><td>1</td>
      <td>0</td><td>1</td><td>0</td>
      <td>1</td><td>1</td><td>0</td>
    </tr>
    <tr>
      <td>0</td><td>0</td><td>1</td><td>1</td><td>0</td>
      <td>0</td><td>1</td><td>0</td>
      <td>0</td><td>0</td><td>1</td>
    </tr>
    <tr>
      <td>0</td><td>0</td><td>1</td><td>1</td><td>1</td>
      <td>1</td><td>1</td><td>0</td>
      <td>0</td><td>1</td><td>1</td>
    </tr>
    <tr>
      <td>0</td><td>1</td><td>0</td><td>0</td><td>1</td>
      <td>0</td><td>1</td><td>0</td>
      <td>1</td><td>1</td><td>0</td>
    </tr>
    <tr>
      <td>0</td><td>1</td><td>0</td><td>1</td><td>0</td>
      <td>0</td><td>1</td><td>0</td>
      <td>1</td><td>0</td><td>0</td>
    </tr>
    <tr>
      <td>0</td><td>1</td><td>1</td><td>0</td><td>0</td>
      <td>0</td><td>0</td><td>1</td>
      <td>1</td><td>0</td><td>0</td>
    </tr>
    <tr>
      <td>0</td><td>1</td><td>1</td><td>0</td><td>1</td>
      <td>1</td><td>0</td><td>1</td>
      <td>1</td><td>1</td><td>0</td>
    </tr>
    <tr>
      <td>0</td><td>1</td><td>1</td><td>1</td><td>1</td>
      <td>0</td><td>1</td><td>1</td>
      <td>1</td><td>1</td><td>1</td>
    </tr>
    <tr>
      <td>1</td><td>0</td><td>0</td><td>0</td><td>1</td>
      <td>0</td><td>1</td><td>0</td>
      <td>1</td><td>1</td><td>0</td>
    </tr>
    <tr>
      <td>1</td><td>0</td><td>0</td><td>1</td><td>0</td>
      <td>0</td><td>1</td><td>0</td>
      <td>1</td><td>0</td><td>0</td>
    </tr>
    <tr>
      <td>1</td><td>0</td><td>1</td><td>0</td><td>0</td>
      <td>0</td><td>0</td><td>1</td>
      <td>1</td><td>0</td><td>0</td>
    </tr>
    <tr>
      <td>1</td><td>0</td><td>1</td><td>0</td><td>1</td>
      <td>1</td><td>0</td><td>1</td>
      <td>1</td><td>1</td><td>0</td>
    </tr>
    <tr>
      <td>1</td><td>0</td><td>1</td><td>1</td><td>1</td>
      <td>0</td><td>1</td><td>1</td>
      <td>1</td><td>1</td><td>1</td>
    </tr>
    <tr>
      <td>1</td><td>1</td><td>0</td><td>0</td><td>1</td>
      <td>1</td><td>0</td><td>1</td>
      <td>0</td><td>1</td><td>1</td>
    </tr>
    <tr>
      <td>1</td><td>1</td><td>0</td><td>1</td><td>1</td>
      <td>0</td><td>1</td><td>1</td>
      <td>1</td><td>1</td><td>1</td>
    </tr>
    <tr>
      <td>1</td><td>1</td><td>1</td><td>0</td><td>1</td>
      <td>0</td><td>1</td><td>1</td>
      <td>1</td><td>1</td><td>1</td>
    </tr>
    <tr>
      <td>1</td><td>1</td><td>1</td><td>1</td><td>0</td>
      <td>0</td><td>1</td><td>1</td>
      <td>0</td><td>0</td><td>1</td>
    </tr>
    <tr>
      <td>1</td><td>1</td><td>1</td><td>1</td><td>1</td>
      <td>1</td><td>1</td><td>1</td>
      <td>0</td><td>1</td><td>1</td>
    </tr>
  </tbody>
</table>

20 out of 32 cases have errors: 16 in Sum, 8 in Carry and 6 in C<sub>out</sub>

1 imagae will be added here for 1st stage of reduction
*Placeholder for 1st stage of reduction*

### Final Summation
After the partial product reduction, the remaining Sum and Carry-out bits are processed using half adders and full adders to generate the final output.

1 image will be added here for final summation
*Placeholder for final summation stage*

---

## Results and Analysis
The following images demonstrate that the design meets the specified criteria for:
1. **Error**: Mean relative error = 8.23% (less than 10%)

![mean_relative_error = 8.23%](https://github.com/user-attachments/assets/128f9619-f260-4419-971e-fea3c35bb096)

2. **Power Utilization**: 40 mW for logic (Efficient power usage)

![power = 40mW for logic](https://github.com/user-attachments/assets/609c2229-5d5d-44b9-803c-dc24b9466489)
   
3. **LUT Utilization**: Number of LUTs = 9 (less than 12)

![utilisation = 9 LUTs](https://github.com/user-attachments/assets/4ea8b0ef-42a2-4a65-9fa7-7551ee07e305)

---

Feel free to clone this repository and explore the implementation!
