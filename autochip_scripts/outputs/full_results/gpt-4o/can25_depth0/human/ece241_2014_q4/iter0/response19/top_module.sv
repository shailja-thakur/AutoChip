module top_module (
    input clk,
    input x,
    output z
);
    // Wires to connect gates and flip-flops
    wire q1, q2, q3;
    wire d1, d2, d3;
    wire q1n, q2n, q3n;
    wire xnor_out;

    // D Flip-Flops
    reg q1_reg, q2_reg, q3_reg;

    always @(posedge clk) begin
        q1_reg <= d1;
        q2_reg <= d2;
        q3_reg <= d3;
    end

    // Complementary outputs
    assign q1n = ~q1_reg;
    assign q2n = ~q2_reg;
    assign q3n = ~q3_reg;

    // Gates
    assign d1 = x ^ q1_reg;  // XOR gate
    assign d2 = x & q2n;     // AND gate with complementary output
    assign d3 = x | q3n;     // OR gate with complementary output

    // Flip-Flop outputs
    assign q1 = q1_reg;
    assign q2 = q2_reg;
    assign q3 = q3_reg;

    // 3-input XNOR gate: z = ~(q1 ^ q2 ^ q3)
    assign xnor_out = ~(q1 ^ q2 ^ q3);
    assign z = xnor_out;

endmodule
