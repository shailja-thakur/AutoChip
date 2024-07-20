module top_module (
    input clk,
    input x,
    output z
);

    wire q1, q2, q3;
    wire q1_n, q2_n, q3_n;
    wire d1, d2, d3;
    wire x_xor_q1, x_and_q2_n, x_or_q3_n;

    // Define flip-flop outputs and their complements
    assign q1_n = ~q1;
    assign q2_n = ~q2;
    assign q3_n = ~q3;

    // Combinational logic
    assign x_xor_q1 = x ^ q1;
    assign x_and_q2_n = x & q2_n;
    assign x_or_q3_n = x | q3_n;

    // Inputs to the D flip-flops
    assign d1 = x_xor_q1;
    assign d2 = x_and_q2_n;
    assign d3 = x_or_q3_n;

    // D flip-flops
    always @(posedge clk) begin
        q1 <= d1;
        q2 <= d2;
        q3 <= d3;
    end

    // XNOR gate output
    assign z = ~(q1 ^ q2 ^ q3);

endmodule
