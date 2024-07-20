module top_module (
    input clk,
    input x,
    output z
);

    wire q1, q2, q3;
    wire nq1, nq2, nq3;

    // D Flip-Flops
    dff dff1 (.clk(clk), .d(q1), .q(q1), .nq(nq1));
    dff dff2 (.clk(clk), .d(q2), .q(q2), .nq(nq2));
    dff dff3 (.clk(clk), .d(q3), .q(q3), .nq(nq3));

    // XOR Gate
    xor xor1 (q1, x);
    xor xor2 (q2, x);
    xor xor3 (q3, x);

    // AND Gate
    and and1 (q1, nq1);
    and and2 (q2, nq2);
    and and3 (q3, nq3);

    // OR Gate
    or or1 (q1, nq1);
    or or2 (q2, nq2);
    or or3 (q3, nq3);

    // XNOR Gate
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
