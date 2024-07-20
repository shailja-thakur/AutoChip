module top_module (
    input clk,
    input x,
    output z
);
    reg d1, d2, d3;
    wire xor_out, and_out, or_out;
    wire d1_bar, d2_bar, d3_bar;

    // Flip-flop outputs
    always @(posedge clk) begin
        d1 <= xor_out;
        d2 <= and_out;
        d3 <= or_out;
    end

    // Complemented outputs of flip-flops
    assign d1_bar = ~d1;
    assign d2_bar = ~d2;
    assign d3_bar = ~d3;

    // Gates
    assign xor_out = x ^ d1;
    assign and_out = x & d2_bar;
    assign or_out = x | d3_bar;

    // 3-input XNOR gate
    assign z = ~(d1 ^ d2 ^ d3);

endmodule
