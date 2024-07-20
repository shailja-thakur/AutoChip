module top_module (
    input clk,
    input x,
    output z
);

    reg d1, d2, d3;
    wire q1, q2, q3;
    wire not_q1, not_q2, not_q3;

    // D flip-flops
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            d1 <= 0;
            d2 <= 0;
            d3 <= 0;
        end else begin
            d1 <= x ^ q1;
            d2 <= x & ~q2;
            d3 <= x | ~q3;
        end
    end

    // Flip-flop outputs
    assign q1 = d1;
    assign q2 = d2;
    assign q3 = d3;

    // Complementary outputs
    assign not_q1 = ~q1;
    assign not_q2 = ~q2;
    assign not_q3 = ~q3;

    // Three-input XNOR gate
    assign z = ~(q1 ^ q2 ^ q3);

endmodule
