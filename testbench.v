`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.03.2025 12:32:39
// Design Name: 
// Module Name: testbench
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


`timescale 1ns / 1ps

module UnitNeuron_tb;

    // Inputs
    reg clk;
    reg rst;
    reg [31:0] y_t;     // Current neuron state
    reg [31:0] tau;     // Time constant
    reg [31:0] dt;      // Time step
    reg [31:0] input_i; // External input
    reg [31:0] weight;  // Synaptic weight
    reg [31:0] bias;    // Neuron bias
    reg [31:0] y_j;     // State of connected neuron

    // Output
    wire [31:0] y_t_next; // Updated neuron state

    // Instantiate the UnitNeuron module
    UnitNeuron uut (
        .clk(clk),
        .rst(rst),
        .y_t(y_t),
        .tau(tau),
        .dt(dt),
        .input_i(input_i),
        .weight(weight),
        .bias(bias),
        .y_j(y_j),
        .y_t_next(y_t_next)
    );

    // Clock generation
    always #5 clk = ~clk; // 10ns period (100MHz clock)

    // Testbench procedure
    initial begin
        $dumpfile("UnitNeuron_tb.vcd");
        $dumpvars(0, UnitNeuron_tb);

        // Initialize values
        clk = 0;
        rst = 1;
        y_t = 32'h3F800000;     // 1.0 in IEEE 754
        tau = 32'h40000000;     // 2.0 in IEEE 754
        dt = 32'h3E800000;      // 0.25 in IEEE 754
        input_i = 32'h3F000000; // 0.5 in IEEE 754
        weight = 32'h3F800000;  // 1.0 in IEEE 754
        bias = 32'h3F000000;    // 0.5 in IEEE 754
        y_j = 32'h3F400000;     // 0.75 in IEEE 754

        // Apply reset
        #10 rst = 0;

        // Wait for computations
        #100;

        // Display results
        $display("y_t       = %h", y_t);
        $display("tau       = %h", tau);
        $display("dt        = %h", dt);
        $display("input_i   = %h", input_i);
        $display("weight    = %h", weight);
        $display("bias      = %h", bias);
        $display("y_j       = %h", y_j);
        $display("y_t_next  = %h", y_t_next);

        // End simulation
        #50 $finish;
    end

endmodule

