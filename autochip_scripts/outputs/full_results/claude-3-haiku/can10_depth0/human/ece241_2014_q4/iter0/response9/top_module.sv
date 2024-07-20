module top_module (
    input clk,
    input x,
    output z
);

    wire q1, q2, q3;
    wire q1_bar, q2_bar, q3_bar;

    // D Flip-Flops
    dff dff1 (.clk(clk), .d(x ^ q1), .q(q1), .q_bar(q1_bar));
    dff dff2 (.clk(clk), .d(x & q2_bar), .q(q2), .q_bar(q2_bar));
    dff dff3 (.clk(clk), .d(x | q3_bar), .q(q3), .q_bar(q3_bar));

    // Output Logic
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
