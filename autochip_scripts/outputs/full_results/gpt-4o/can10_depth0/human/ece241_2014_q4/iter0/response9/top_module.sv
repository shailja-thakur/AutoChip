module top_module (
    input clk,
    input x,
    output z
);

    wire q1, q2, q3;
    wire x_xor_q1, x_and_q2_n, x_or_q3_n;
    wire q2_n, q3_n;

    // D Flip-Flops
    reg d1, d2, d3;

    // Ensure the D flip-flops are initially reset to zero
    initial begin
        d1 = 0;
        d2 = 0;
        d3 = 0;
    end

    // Flip-flop outputs
    assign q1 = d1;
    assign q2 = d2;
    assign q3 = d3;

    // Complemented outputs for AND and OR gates
    assign q2_n = ~q2;
    assign q3_n = ~q3;

    // Gates
    assign x_xor_q1 = x ^ q1;
    assign x_and_q2_n = x & q2_n;
    assign x_or_q3_n = x | q3_n;

    // D Flip-Flop inputs
    always @(posedge clk) begin
        d1 <= x_xor_q1;
        d2 <= x_and_q2_n;
        d3 <= x_or_q3_n;
    end

    // XNOR gate
    assign z = ~(q1 ^ q2 ^ q3);

endmodule
