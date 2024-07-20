module top_module (
    input clk,
    input x,
    output z
);

    wire q1, q2, q3;
    wire q1_n, q2_n, q3_n;

    // D flip-flops
    dff d1 (.clk(clk), .d(q1), .q(q1), .q_n(q1_n));
    dff d2 (.clk(clk), .d(q2), .q(q2), .q_n(q2_n));
    dff d3 (.clk(clk), .d(q3), .q(q3), .q_n(q3_n));

    // XOR gates
    assign q1 = x ^ q1;
    assign q2 = x ^ q2;
    assign q3 = x ^ q3;

    // AND gates
    assign q2_n = ~q2;
    assign q3_n = ~q3;
    wire and1 = x & q1_n;
    wire and2 = x & q2_n;
    wire and3 = x & q3_n;

    // OR gates
    wire or1 = x | q1;
    wire or2 = x | q2;
    wire or3 = x | q3;

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
