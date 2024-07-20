module top_module (
    input clk,
    input x,
    output z
);

    wire q1, q2, q3, q1_bar, q2_bar, q3_bar;
    wire xor_out, and_out, or_out;

    // D Flip-Flops
    dff dff1 (.clk(clk), .d(xor_out), .q(q1), .q_bar(q1_bar));
    dff dff2 (.clk(clk), .d(and_out), .q(q2), .q_bar(q2_bar));
    dff dff3 (.clk(clk), .d(or_out), .q(q3), .q_bar(q3_bar));

    // Gates
    assign xor_out = x ^ q1;
    assign and_out = x & q2_bar;
    assign or_out = x | q3_bar;

    // Output
    assign z = ~(xor_out ^ and_out ^ or_out);

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
