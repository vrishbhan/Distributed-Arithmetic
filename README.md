# Distributed Arithmetic
 
Design for a distributed-arithmetic based 6-tap FIR filter, y(n) = a<sub>0</sub>x(n) +
a<sub>1</sub>x(n-1) + a<sub>2</sub>x(n-2) + a<sub>3</sub>x(n-3) + a<sub>4</sub>x(n-4) + a<sub>5</sub>x(n-5) using Verilog

Coefficients are signed and a<sub>0</sub> = 0111, a<sub>1</sub>
= 1001, a<sub>2</sub> = 0101, a<sub>3</sub>= 0101, a<sub>4</sub>= 1011, and a<sub>5</sub> = 0011. 

The Design was verified by obtaining y(n) in 6-bit
representation when x(0) = 1011, x(1) = 0101, x(2) = 1111, x(3)= 0110, x(4)= 1110, x(5)= 0110, x(6)= 1110, and x(7) = 0011. 

Design was implemented with rounding and saturation.
