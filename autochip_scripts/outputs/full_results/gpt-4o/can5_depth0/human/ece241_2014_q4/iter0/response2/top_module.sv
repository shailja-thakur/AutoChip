module top_module (
    input clk,
    input x,
    output z
);

    reg d1, d2, d3; // D flip-flop outputs

    wire xor_out, and_out, or_out;
    wire not_d1, not_d2, not_d3;
    
    // Calculate the complemented outputs of the flip-flops
    assign not_d1 = ~d1;
    assign not_d2 = ~d2;
    assign not_d3 = ~d3;

    // XOR gate, AND gate, and OR gate computations
    assign xor_out = x ^ d1;
    assign and_out = x & not_d2;
    assign or_out = x | not_d3;

    // D flip-flops with synchronous reset to zero
    always @(posedge clk) begin
        d1 <= xor_out;
        d2 <= and_out;
        d3 <= or_out;
    end

    // 3-input XNOR gate computation
    assign z = ~(d1 ^ d2 ^ d3);

endmodule
