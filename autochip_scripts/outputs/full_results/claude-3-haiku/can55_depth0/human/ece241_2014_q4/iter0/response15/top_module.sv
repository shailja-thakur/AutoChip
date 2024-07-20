module top_module (
    input clk,
    input x,
    output z
);

    wire q1, q2, q3;
    wire q1_bar, q2_bar, q3_bar;

    // D Flip-Flops
    dff d1 (.clk(clk), .d(q1), .q(q1), .q_bar(q1_bar));
    dff d2 (.clk(clk), .d(q2), .q(q2), .q_bar(q2_bar));
    dff d3 (.clk(clk), .d(q3), .q(q3), .q_bar(q3_bar));

    // Gates
    assign q1 = x ^ q1;
    assign q2 = x & q2_bar;
    assign q3 = x | q3_bar;

    // XNOR
    assign z = ~(q1 ^ q2 ^ q3);

endmodule
module dff (
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
