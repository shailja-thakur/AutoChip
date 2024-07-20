module top_module (
    input clk,
    input x,
    output z
);

wire q1, q2, q3;
wire not_q1, not_q2, not_q3;

// D flip-flops
dff_reset dff1 (.clk(clk), .d(x ^ q1), .q(q1), .q_n(not_q1));
dff_reset dff2 (.clk(clk), .d(x & not_q2), .q(q2), .q_n(not_q2));
dff_reset dff3 (.clk(clk), .d(x | not_q3), .q(q3), .q_n(not_q3));

// XNOR gate
assign z = ~(q1 ^ q2 ^ q3);

// Module for D flip-flop with reset
module dff_reset (
    input clk,
    input d,
    output reg q,
    output reg q_n
);

    initial begin
        q = 1'b0;
        q_n = 1'b1;
    end

    always @(posedge clk) begin
        q <= d;
        q_n <= ~d;
    end

endmodule
