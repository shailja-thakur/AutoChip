module top_module (
    input clk,
    input x,
    output z
);

    // Internal signals to hold D flip-flop values
    reg d1, d2, d3;

    // Intermediate signals for gate outputs
    wire xor_out, and_out, or_out;

    // Compute the outputs of the XOR, AND, and OR gates
    assign xor_out = x ^ d1;
    assign and_out = x & ~d2;
    assign or_out = x | ~d3;

    // D flip-flops
    always @(posedge clk) begin
        d1 <= xor_out;
        d2 <= and_out;
        d3 <= or_out;
    end

    // Compute the final output z as the three-input XNOR of the flip-flop outputs
    assign z = ~(d1 ^ d2 ^ d3);

endmodule
