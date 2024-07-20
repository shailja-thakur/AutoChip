module top_module (
    input clk,
    input x,
    output z
);

    wire q1, q2, q3;
    wire q1_n, q2_n, q3_n;

    // D Flip-Flops
    dff dff1 (.clk(clk), .d(x ^ q1), .q(q1), .q_n(q1_n));
    dff dff2 (.clk(clk), .d(x & q2_n), .q(q2), .q_n(q2_n));
    dff dff3 (.clk(clk), .d(x | q3_n), .q(q3), .q_n(q3_n));

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
