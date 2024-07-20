module top_module (
    input clk,
    input x,
    output z
);

    wire q1, q2, q3;
    wire nq1, nq2, nq3;

    // D Flip-Flops
    dff d1 (.clk(clk), .d(^{x, q1}), .q(q1), .nq(nq1));
    dff d2 (.clk(clk), .d(x & nq2), .q(q2), .nq(nq2));
    dff d3 (.clk(clk), .d(x | nq3), .q(q3), .nq(nq3));

    // XNOR gate
    assign z = ~(q1 ^ q2 ^ q3);

endmodule
module dff (
    input clk,
    input d,
    output reg q,
    output reg nq
);

    always @(posedge clk) begin
        q <= d;
        nq <= ~d;
    end

endmodule
