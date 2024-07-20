module top_module (
    input clk,
    input x,
    output z
);

    wire d1, d2, d3;
    wire q1, q2, q3;
    wire q1_bar, q2_bar, q3_bar;

    // D Flip-Flops
    dff dff1 (.clk(clk), .d(d1), .q(q1), .q_bar(q1_bar));
    dff dff2 (.clk(clk), .d(d2), .q(q2), .q_bar(q2_bar));
    dff dff3 (.clk(clk), .d(d3), .q(q3), .q_bar(q3_bar));

    // XOR Gate
    xor xor1 (.a(x), .b(q1), .y(d1));
    xor xor2 (.a(x), .b(q2), .y(d2));
    xor xor3 (.a(x), .b(q3), .y(d3));

    // AND Gate
    and and1 (.a(x), .b(q1_bar), .y(d1));
    and and2 (.a(x), .b(q2_bar), .y(d2));
    and and3 (.a(x), .b(q3_bar), .y(d3));

    // OR Gate
    or or1 (.a(x), .b(q1_bar), .y(d1));
    or or2 (.a(x), .b(q2_bar), .y(d2));
    or or3 (.a(x), .b(q3_bar), .y(d3));

    // XNOR Gate
    xnor xnor1 (.a(q1), .b(q2), .c(q3), .y(z));

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
