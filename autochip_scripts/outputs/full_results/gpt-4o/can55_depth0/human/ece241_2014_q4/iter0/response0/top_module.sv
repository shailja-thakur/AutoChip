module top_module (
    input clk,
    input x,
    output z
);

    // Intermediate signals for flip-flop outputs
    reg d_ff1_q, d_ff2_q, d_ff3_q;

    // Complementary outputs of flip-flops
    wire d_ff1_q_bar = ~d_ff1_q;
    wire d_ff2_q_bar = ~d_ff2_q;
    wire d_ff3_q_bar = ~d_ff3_q;

    // Next state logic for the flip-flops
    wire xor_out = x ^ d_ff1_q;
    wire and_out = x & d_ff2_q_bar;
    wire or_out = x | d_ff3_q_bar;

    // Flip-flops (DFF) to hold state
    always @(posedge clk) begin
        d_ff1_q <= xor_out;
        d_ff2_q <= and_out;
        d_ff3_q <= or_out;
    end

    // Output logic
    assign z = ~(d_ff1_q ~^ d_ff2_q ~^ d_ff3_q);

endmodule
