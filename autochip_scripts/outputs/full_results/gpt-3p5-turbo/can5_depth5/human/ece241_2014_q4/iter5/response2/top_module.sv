module top_module (
    input clk,
    input x,
    output reg z
);

reg d1, d2, d3;
wire d1_out, d2_out, d3_out;

assign d1_out = x ^ d1;
assign d2_out = ~(d2 & d1_out);
assign d3_out = ~(d3 | d1_out);
assign z = ~(d1_out ^ d2_out ^ d3_out);

always @(posedge clk) begin
    d1 <= d1_out;
    d2 <= d2_out;
    d3 <= d3_out;
end

initial begin
    d1 <= 1'b0;
    d2 <= 1'b0;
    d3 <= 1'b0;
end

endmodule
