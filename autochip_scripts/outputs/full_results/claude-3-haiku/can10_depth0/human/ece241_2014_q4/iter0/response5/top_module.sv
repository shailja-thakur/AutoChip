module top_module (
    input clk,
    input x,
    output z
);

    wire d1, d2, d3;
    wire q1, q2, q3;
    wire not_q1, not_q2, not_q3;

    // D flip-flops
    dff d_ff1 (.clk(clk), .d(d1), .q(q1), .q_n(not_q1));
    dff d_ff2 (.clk(clk), .d(d2), .q(q2), .q_n(not_q2));
    dff d_ff3 (.clk(clk), .d(d3), .q(q3), .q_n(not_q3));

    // Combinational logic
    assign d1 = x ^ q1;
    assign d2 = x & not_q2;
    assign d3 = x | not_q3;

    // Output logic
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
