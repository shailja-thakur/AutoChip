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

    // D flip-flops
    dff dff1 (.clk(clk), .d(d1), .q(q1), .q_n(nq1));
    dff dff2 (.clk(clk), .d(d2), .q(q2), .q_n(nq2));
    dff dff3 (.clk(clk), .d(d3), .q(q3), .q_n(nq3));

    // XNOR gate
    assign z = ~(q1 ^ q2 ^ q3);

endmodule
module dff (
    input clk,
    input d,
    output reg q,
    output reg q_n
);

    always @(posedge clk) begin
        q <= d;
        q_n <= ~d;
    end

endmodule
