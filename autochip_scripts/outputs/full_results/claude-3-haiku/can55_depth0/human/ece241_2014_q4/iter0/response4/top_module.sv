module top_module (
    input clk,
    input x,
    output z
);

    wire q1, q2, q3, q1_bar, q2_bar, q3_bar;
    wire xor_out, and_out, or_out;

    // D Flip-Flops
    dff d1 (.clk(clk), .d(xor_out), .q(q1), .q_bar(q1_bar));
    dff d2 (.clk(clk), .d(and_out), .q(q2), .q_bar(q2_bar));
    dff d3 (.clk(clk), .d(or_out), .q(q3), .q_bar(q3_bar));

    // XOR Gate
    xor(xor_out, x, q1);

    // AND Gate
    and(and_out, x, q2_bar);

    // OR Gate
    or(or_out, x, q3_bar);

    // XNOR Gate
    xnor(z, q1, q2, q3);

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
