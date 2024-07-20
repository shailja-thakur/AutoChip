module top_module (
    input clk,
    input x,
    output z
);

    wire q1, q2, q3;
    wire nq1, nq2, nq3;

    // D flip-flops
    dff d1 (.clk(clk), .d(q1), .q(q1), .nq(nq1));
    dff d2 (.clk(clk), .d(q2), .q(q2), .nq(nq2));
    dff d3 (.clk(clk), .d(q3), .q(q3), .nq(nq3));

    // XOR gates
    xor xor1 (q1, x, q1);
    xor xor2 (q2, x, q2);
    xor xor3 (q3, x, q3);

    // AND gates
    and and1 (q1, x, nq1);
    and and2 (q2, x, nq2);
    and and3 (q3, x, nq3);

    // OR gates
    or or1 (q1, x, nq1);
    or or2 (q2, x, nq2);
    or or3 (q3, x, nq3);

    // XNOR gate
    xnor xnor1 (z, q1, q2, q3);

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
