
`timescale 1ns / 1ps


module UnitNeuron (
    input clk,              // Clock signal
    input rst,              // Reset signal
    input [31:0] y_t,       // Current state of the neuron (IEEE 754)
    input [31:0] tau,       // Time constant (IEEE 754)
    input [31:0] dt,        // Time step (IEEE 754)
    input [31:0] input_i,   // External input (IEEE 754)
    input [31:0] weight,    // Weight w_ij (IEEE 754)
    input [31:0] bias,      // Bias theta_j (IEEE 754)
    input [31:0] y_j,       // State of connected neuron j (IEEE 754)
    output  [31:0] y_t_next  // Updated neuron state (IEEE 754)
);

    // Intermediate signals
    wire [31:0] neg_y_t;      // -y_t
    wire [31:0] weighted_sum; // weight * sigma(y_j + bias)
    wire [31:0] neuron_input; // sum of inputs
    wire [31:0] sigma_input;  // y_j + bias
    wire [31:0] sigma_out;    // Sigmoid output
    wire [31:0] temp1, temp2, dt_div_tau, update_term;
    wire [31:0] y_t_next_w;
    // Divider control signals
    reg div_input_a_stb, div_input_b_stb;
    wire div_input_a_ack, div_input_b_ack, div_output_z_stb;
    reg div_output_z_ack;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            //y_t_next_r <= 32'b0;
            div_input_a_stb <= 0;
            div_input_b_stb <= 0;
            div_output_z_ack <= 0;
        end 
        end
            // Compute neg_y_t = -y_t
            floating_point_multiply negation (
                .clk(clk),
                .a(y_t),
                .b(32'hBF800000),  // -1 in IEEE 754
                .result(neg_y_t)
            );

            // Compute sigma_input = y_j + bias
            floating_point_add sigma_floating_point_add (
                .clk(clk),
                .a(y_j),
                .b(bias),
                .result(sigma_input)
            );

            // Compute sigma_out = sigmoid(y_j + bias)
            Sigmoid activation (
                .clk(clk),
                .rst(rst),
                .numb(sigma_input),
                .sigmoid_out(sigma_out)
            );

            // Compute weighted_sum = weight * sigma_out
            floating_point_multiply weight_multiply (
                .clk(clk),
                .a(weight),
                .b(sigma_out),
                .result(weighted_sum)
            );

            // Compute neuron_input = weighted_sum + input_i
            floating_point_add input_sum (
                .clk(clk),
                .a(weighted_sum),
                .b(input_i),
                .result(neuron_input)
            );

            // Compute temp1 = neg_y_t + neuron_input
            floating_point_add sum_neuron_inputs (
                .clk(clk),
                .a(neg_y_t),
                .b(neuron_input),
                .result(temp1)
            );

            // Divider for dt / tau
            FloatingDivision dt_tau_div (
                .clk(clk),
                .A(dt), 
               // .input_a_stb(div_input_a_stb),
                //.input_a_ack(div_input_a_ack),
                .B(tau),
             //   .input_b_stb(div_input_b_stb),
               // .input_b_ack(div_input_b_ack),
                .result(dt_div_tau)
               // .output_z_stb(div_output_z_stb),
                //.output_z_ack(div_output_z_ack)
            );

            // Control the division operation strobe signals
//            always@(posedge clk) begin
//            div_input_a_stb <= 1;
//            div_input_b_stb <= 1;
//            if (div_output_z_stb) begin
//                div_output_z_ack <= 1;
//            end else begin
//                div_output_z_ack <= 0;
//            end
// end
            // Compute update_term = (dt / tau) * temp1
            floating_point_multiply update_term_mult (
                .clk(clk),
                .a(dt_div_tau),
                .b(temp1),
                .result(update_term)
            );

            // Compute y_t_next = y_t + update_term
            floating_point_add next_state_calc (
                .clk(clk),
                .a(y_t),
                .b(update_term),
                .result(y_t_next_w)
            );
        
    assign y_t_next = rst ? 0 : y_t_next_w;

endmodule
