module top_module (
    input clk,
    input x,
    output z
);

    reg q1, q2, q3;
    wire q1_bar, q2_bar, q3_bar;

    // Flip-flop initialization
    initial begin
        q1 = 1'b0;
        q2 = 1'b0;
        q3 = 1'b0;
    end

    // Flip-flop logic
    always @(posedge clk) begin
        q1 <= x ^ q1;
        q2 <= x & ~q2;
        q3 <= x | q3;
    end

    // Complementary outputs
    assign q1_bar = ~q1;
    assign q2_bar = ~q2;
    assign q3_bar = ~q3;

    // Output logic
    assign z = (q1 ^ q1_bar) ~^ (q2 & q2_bar) ~^ (q3 | q3_bar);

endmodule
