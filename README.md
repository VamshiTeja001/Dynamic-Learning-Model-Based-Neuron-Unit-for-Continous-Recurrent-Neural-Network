# Dynamic-Learning-Model-Based-Neuron-Unit-for-Continous-Recurrent-Neural-Network

Designed and implemented a differential equation-based neuron in Verilog, inspired by Neuroevolving Electronic Dynamical Networks by Derek Whitley.
Developed a computational model utilizing floating-point arithmetic, integrating an adder, multiplier, and divider for precise mathematical operations.
Optimized performance with a preloaded sigmoid lookup table, reducing computational latency and improving efficiency.
Enabled hardware acceleration for neuroevolutionary algorithms, facilitating faster processing in FPGA-based or ASIC implementations.

This neuron follows the given differential equation:

𝜏
𝑖
𝑑
𝑦
𝑖
(
𝑡
)
𝑑
𝑡
=
−
𝑦
𝑖
(
𝑡
)
+
∑
𝑗
=
1
𝑁
𝑤
𝑖
𝑗
𝜎
(
𝑦
𝑗
(
𝑡
)
+
𝜃
𝑗
)
+
𝐼
𝑖
(
𝑡
)
τ 
i
​
  
dt
dy 
i
​
 (t)
​
 =−y 
i
​
 (t)+ 
j=1
∑
N
​
 w 
ij
​
 σ(y 
j
​
 (t)+θ 
j
​
 )+I 
i
​
 (t)
