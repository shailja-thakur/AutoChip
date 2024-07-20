module top_module (
    input clk,
    input x,
    output reg z
);
    reg q1, q2, q3;  // Flip-flop outputs
    wire xor_out, and_out, or_out;  // Gate outputs
    wire not_q1, not_q2, not_q3;  // Complemented flip-flop outputs

    // Complementary outputs of flip-flops
    assign not_q1 = ~q1;
    assign not_q2 = ~q2;
    assign not_q3 = ~q3;

    // Gate connections
    assign xor_out = x ^ q1;
    assign and_out = x & not_q2;
    assign or_out = x | not_q3;

    // D flip-flops
    always @(posedge clk) begin
        q1 <= xor_out;
        q2 <= and_out;
        q3 <= or_out;
    end

    // XNOR of the flip-flop outputs
    always @(posedge clk) begin
        z <= ~(q1 ^ q2 ^ q3);
    end
endmodule
