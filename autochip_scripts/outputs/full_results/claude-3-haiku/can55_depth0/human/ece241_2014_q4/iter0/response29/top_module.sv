module top_module (
    input clk,
    input x,
    output z
);

    wire d1, d2, d3;
    wire q1, q2, q3;
    wire q1_bar, q2_bar, q3_bar;

    // XOR gate
    assign d1 = x ^ q1;

    // AND gate
    assign d2 = x & q2_bar;

    // OR gate
    assign d3 = x | q3_bar;

    // D flip-flops
    dff_reset ff1 (.clk(clk), .d(d1), .q(q1), .q_bar(q1_bar));
    dff_reset ff2 (.clk(clk), .d(d2), .q(q2), .q_bar(q2_bar));
    dff_reset ff3 (.clk(clk), .d(d3), .q(q3), .q_bar(q3_bar));

    // XNOR gate
    assign z = ~(q1 ^ q2 ^ q3);

endmodule
module dff_reset (
    input clk,
    input d,
    output reg q,
    output reg q_bar
);

    always @(posedge clk) begin
        q <= d;
        q_bar <= ~d;
    end

endmodule
