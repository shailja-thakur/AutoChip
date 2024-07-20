module top_module (
    input clk,
    input x,
    output z
);

    wire q1, q2, q3, q1_bar, q2_bar, q3_bar;
    D_flip_flop DFF1 (.clk(clk), .d(x ^ q1), .q(q1), .q_bar(q1_bar));
    D_flip_flop DFF2 (.clk(clk), .d(x & q2_bar), .q(q2), .q_bar(q2_bar));
    D_flip_flop DFF3 (.clk(clk), .d(x | q3_bar), .q(q3), .q_bar(q3_bar));

    assign z = ~(q1 ^ q2 ^ q3);

endmodule
module D_flip_flop (
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
