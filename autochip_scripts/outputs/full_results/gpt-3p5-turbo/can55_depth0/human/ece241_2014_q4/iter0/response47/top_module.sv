module top_module (
    input clk,
    input x,
    output reg z
);

reg d1, d2, d3;
wire f1, f2, f3;

always @(posedge clk) begin
    d1 <= x ^ d1;
    d2 <= ~(x & d2);
    d3 <= ~(x | d3);
end

assign f1 = x ^ d1;
assign f2 = ~d2;
assign f3 = ~d3;
assign z = f1 ^ f2 ^ f3;

endmodule
