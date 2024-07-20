module top_module (
    input clk,
    input x,
    output z
);

    reg d1, d2, d3;
    wire q1, q2, q3;
    wire x_xor_q1, x_and_q2_bar, x_or_q3_bar;

    always @(posedge clk) begin
        d1 <= x ^ q1;
        d2 <= x & ~q2;
        d3 <= x | ~q3;
        q1 <= d1;
        q2 <= d2;
        q3 <= d3;
    end

    assign x_xor_q1 = x ^ q1;
    assign x_and_q2_bar = x & ~q2;
    assign x_or_q3_bar = x | ~q3;
    assign z = ~(x_xor_q1 ^ x_and_q2_bar ^ x_or_q3_bar);

endmodule
