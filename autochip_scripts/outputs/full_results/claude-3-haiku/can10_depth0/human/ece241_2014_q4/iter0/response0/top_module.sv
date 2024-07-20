module top_module (
    input clk,
    input x,
    output z
);

    reg q1, q2, q3;
    wire x_xor_q1, x_and_q1_bar, x_or_q1_bar;

    // D Flip-Flop 1
    always @(posedge clk) begin
        q1 <= x ^ q1;
    end

    // D Flip-Flop 2
    always @(posedge clk) begin
        q2 <= x & ~q2;
    end

    // D Flip-Flop 3
    always @(posedge clk) begin
        q3 <= x | ~q3;
    end

    // Output Logic
    assign x_xor_q1 = x ^ q1;
    assign x_and_q1_bar = x & ~q1;
    assign x_or_q1_bar = x | ~q1;
    assign z = ~(x_xor_q1 ^ x_and_q1_bar ^ x_or_q1_bar);

endmodule
