module top_module (
    input clk,
    input x,
    output z
);
    // Flip-flop declarations
    reg d_ff1, d_ff2, d_ff3;

    // Intermediate wires
    wire xor_out, and_out, or_out;
    wire d_ff2_bar, d_ff3_bar;

    // Complementary outputs
    assign d_ff2_bar = ~d_ff2;
    assign d_ff3_bar = ~d_ff3;

    // Gate operations
    assign xor_out = x ^ d_ff1;
    assign and_out = x & d_ff2_bar;
    assign or_out = x | d_ff3_bar;

    // D flip-flop behavior on clock edge
    always @(posedge clk) begin
        d_ff1 <= xor_out;
        d_ff2 <= and_out;
        d_ff3 <= or_out;
    end

    // XNOR gate taking flip-flop outputs
    assign z = ~(d_ff1 ^ d_ff2 ^ d_ff3);

endmodule
