module top_module (
    input clk,
    input x,
    output z
);

    reg ff1, ff2, ff3; // Flip-flops

    wire xor_out, and_out, or_out;
    wire ff1_n, ff2_n, ff3_n; // Complementary outputs of flip-flops

    // Complementary outputs of flip-flops
    assign ff1_n = ~ff1;
    assign ff2_n = ~ff2;
    assign ff3_n = ~ff3;

    // Logic gates for inputs to D flip-flops
    assign xor_out = x ^ ff1;
    assign and_out = x & ff2_n;
    assign or_out = x | ff3_n;

    // D flip-flops with synchronous reset
    always @(posedge clk) begin
        ff1 <= xor_out;
        ff2 <= and_out;
        ff3 <= or_out;
    end

    // Three-input XNOR gate
    assign z = ~(ff1 ^ ff2 ^ ff3);

endmodule
