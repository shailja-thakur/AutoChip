module top_module (
    input clk,
    input x,
    output z
);

    // Declare intermediate wires
    wire d1, d2, d3;
    wire q1, q2, q3;
    wire q1_n, q2_n, q3_n;
    wire xnor_out;

    // Instantiate flip-flops
    dff ff1 (
        .clk(clk),
        .d(d1),
        .q(q1)
    );

    dff ff2 (
        .clk(clk),
        .d(d2),
        .q(q2)
    );

    dff ff3 (
        .clk(clk),
        .d(d3),
        .q(q3)
    );

    // Complementary outputs of flip-flops
    assign q1_n = ~q1;
    assign q2_n = ~q2;
    assign q3_n = ~q3;

    // Inputs to the flip-flops
    assign d1 = x ^ q1;   // XOR
    assign d2 = x & q2_n; // AND
    assign d3 = x | q3_n; // OR

    // XNOR of flip-flop outputs
    assign xnor_out = ~(q1 ^ q2 ^ q3);
    assign z = xnor_out;

endmodule
module dff (
    input clk,
    input d,
    output reg q
);

    always @(posedge clk) begin
        q <= d;
    end

endmodule
