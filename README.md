# Dynamic-Learning-Model-Based-Neuron-Unit-for-Continous-Recurrent-Neural-Network

Designed and implemented a differential equation-based neuron in Verilog, inspired by Neuroevolving Electronic Dynamical Networks by Derek Whitley.
Developed a computational model utilizing floating-point arithmetic, integrating an adder, multiplier, and divider for precise mathematical operations.
Optimized performance with a preloaded sigmoid lookup table, reducing computational latency and improving efficiency.
Enabled hardware acceleration for neuroevolutionary algorithms, facilitating faster processing in FPGA-based or ASIC implementations.

This neuron follows the given differential equation:

![image](https://github.com/user-attachments/assets/33be0aec-2a27-4cae-9e58-7b25757edc1e)



Where:

𝑦
𝑖
(
𝑡
)
y 
i
​
 (t) is the neuron's state.
𝜏
𝑖
τ 
i
​
  is the time constant.
𝑤
𝑖
𝑗
w 
ij
​
  is the weight from neuron 
𝑗
j to neuron 
𝑖
i.
𝜃
𝑗
θ 
j
​
  is the bias.
𝐼
𝑖
(
𝑡
)
I 
i
​
 (t) is the external input.
𝜎
(
𝑥
)
σ(x) is the sigmoid activation function.


Implementation Details:
Uses 32-bit IEEE 754 floating-point representation.
Euler method is used for numerical integration.


Inputs:
clk: Clock signal.
rst: Reset signal.
tau_inv: Inverse of the time constant (
1
𝜏
τ
1
​
 ), precomputed for efficiency.
y_prev: Previous state 
𝑦
𝑖
(
𝑡
)
y 
i
​
 (t).
weights: Array of weights 
𝑤
𝑖
𝑗
w 
ij
​
 .
inputs: Array of presynaptic neuron states 
𝑦
𝑗
(
𝑡
)
y 
j
​
 (t).
bias: Bias 
𝜃
𝑗
θ 
j
​
 .
external_input: 
𝐼
𝑖
(
𝑡
)
I 
i
​
 (t).
dt: Time step for integration.


Outputs:
y_next: Next state 
𝑦
𝑖
(
𝑡
+
𝑑
𝑡
)
y 
i
​
 (t+dt).
