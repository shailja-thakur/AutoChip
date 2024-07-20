module top_module (
    input clk,
    input x,
    output z
);

    wire d1, d2, d3;  // D inputs for the flip-flops
    wire q1, q2, q3;  // Q outputs of the flip-flops
    wire nq1, nq2, nq3;  // Complementary Q outputs of the flip-flops
    wire z_xor, z_and, z_or;  // Outputs of the XOR, AND, and OR gates

    // D flip-flops with asynchronous reset, initially reset to zero
    reg q1_reg, q2_reg, q3_reg;

    always @ (posedge clk) begin
        q1_reg <= d1;
        q2_reg <= d2;
        q3_reg <= d3;
    end

    // Assign flip-flop outputs
    assign q1 = q1_reg;
    assign q2 = q2_reg;
    assign q3 = q3_reg;

    // Complementary outputs
    assign nq1 = ~q1;
    assign nq2 = ~q2;
    assign nq3 = ~q3;

    // Logic gates
    assign d1 = x ^ q1;     // XOR gate
    assign d2 = x & nq2;    // AND gate
    assign d3 = x | nq3;    // OR gate

    // Three-input XNOR gate
    assign z = ~(q1 ^ q2 ^ q3);

endmodule
