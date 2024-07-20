module top_module (
    input clk,
    input x,
    output z
);

    wire d1, d2, d3;
    wire q1, q2, q3;
    wire q1_bar, q2_bar, q3_bar;

    // D flip-flops
    dff dff1 (.clk(clk), .d(d1), .q(q1), .q_bar(q1_bar));
    dff dff2 (.clk(clk), .d(d2), .q(q2), .q_bar(q2_bar));
    dff dff3 (.clk(clk), .d(d3), .q(q3), .q_bar(q3_bar));

    // Logic gates
    assign d1 = x ^ q1;
    assign d2 = x & q2_bar;
    assign d3 = x | q3_bar;

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
