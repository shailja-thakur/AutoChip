module top_module (
    input clk,
    input x,
    output z
);

    reg d_ff1, d_ff2, d_ff3;

    wire xor_out, and_out, or_out;
    wire not_d_ff1, not_d_ff2, not_d_ff3;
    wire xnor_out;

    // Inverted outputs of flip-flops
    assign not_d_ff1 = ~d_ff1;
    assign not_d_ff2 = ~d_ff2;
    assign not_d_ff3 = ~d_ff3;

    // XOR, AND, and OR gates 
    assign xor_out = x ^ d_ff1;
    assign and_out = x & not_d_ff2;
    assign or_out = x | not_d_ff3;

    // D flip-flops
    always @(posedge clk) begin
        d_ff1 <= xor_out;
        d_ff2 <= and_out;
        d_ff3 <= or_out;
    end

    // XNOR gate
    assign xnor_out = ~(d_ff1 ^ d_ff2 ^ d_ff3);

    // Output
    assign z = xnor_out;

endmodule
