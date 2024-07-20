module top_module (
    input clk,
    input x,
    output z
);

    wire d1, d2, d3;
    wire q1, q2, q3;
    wire nq1, nq2, nq3;

    // XOR gate
    assign d1 = x ^ q1;

    // AND gate
    assign d2 = x & ~q2;

    // OR gate
    assign d3 = x | ~q3;

    // D Flip-Flops
    dff_reset fd1 (.clk(clk), .d(d1), .q(q1), .nq(nq1));
    dff_reset fd2 (.clk(clk), .d(d2), .q(q2), .nq(nq2));
    dff_reset fd3 (.clk(clk), .d(d3), .q(q3), .nq(nq3));

    // XNOR gate
    assign z = ~(q1 ^ q2 ^ q3);

endmodule
module dff_reset (
    input clk,
    input d,
    output reg q,
    output reg nq
);

    initial begin
        q = 0;
        nq = 1;
    end

    always @(posedge clk) begin
        q <= d;
        nq <= ~d;
    end

endmodule
