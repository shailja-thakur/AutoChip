module top_module (
    input clk,
    input x,
    output z
);
    reg d1, d2, d3;
    wire xor_out, and_out, or_out;
    wire d1_bar, d2_bar, d3_bar;
    wire xnor_out;

    always @(posedge clk) begin
        d1 <= xor_out;
        d2 <= and_out;
        d3 <= or_out;
    end

    assign xor_out = x ^ d1;
    assign d1_bar = ~d1;
    assign and_out = x & d1_bar;
    assign d2_bar = ~d2;
    assign or_out = x | d2_bar;
    assign xnor_out = ~(d1 ^ d2 ^ d3);
    assign z = xnor_out;

endmodule
