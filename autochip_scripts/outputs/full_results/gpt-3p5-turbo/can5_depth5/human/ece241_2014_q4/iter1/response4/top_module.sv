module top_module (
    input clk,
    input x,
    output reg z
);

reg d1, d2, d3;
wire x_xor_d1, d2_complement, d3_complement;

assign x_xor_d1 = x ^ d1;
assign d2_complement = ~(d2 & d1);
assign d3_complement = ~(d3 | d1);
assign z = ~(x_xor_d1 ^ d2_complement ^ d3_complement);

always @(posedge clk) begin
    if (x_xor_d1)
        d1 <= x_xor_d1;
    if (d2_complement)
        d2 <= d2_complement;
    if (d3_complement)
        d3 <= d3_complement;
end

endmodule
