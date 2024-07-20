module top_module (
    input clk,
    input x,
    output z
);

reg d1, d2, d3;
wire n1, n2, n3, z;

assign n1 = ~d1;
assign n2 = ~d2;
assign n3 = ~d3;
assign z = ~(d1 ^ n1 ^ d2 ^ n2 ^ d3 ^ n3);

always @(posedge clk) begin
    d1 <= x ^ d1;
    d2 <= x & n2;
    d3 <= x | n3;
end

endmodule
