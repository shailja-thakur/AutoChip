module top_module (
    input clk,
    input x,
    output z
);

    wire q1, q2, q3, q1_bar, q2_bar, q3_bar;
    wire xor_out, and_out, or_out;

    // D flip-flops
    dff dff1 (.clk(clk), .d(xor_out), .q(q1), .q_bar(q1_bar));
    dff dff2 (.clk(clk), .d(and_out), .q(q2), .q_bar(q2_bar));
    dff dff3 (.clk(clk), .d(or_out), .q(q3), .q_bar(q3_bar));

    // XOR gate
    xor xor_gate (.a(x), .b(q1), .y(xor_out));

    // AND gate
    and and_gate (.a(x), .b(q2_bar), .y(and_out));

    // OR gate
    or or_gate (.a(x), .b(q3_bar), .y(or_out));

    // XNOR gate
    xnor xnor_gate (.a(q1), .b(q2), .c(q3), .y(z));

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
