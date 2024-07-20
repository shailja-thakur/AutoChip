module top_module(
	input clk,
	input [7:0] d,
	output reg [7:0] q);

reg [7:0] q_default = 8'h0;

always @(posedge clk) begin
	q <= d;
end

initial begin
	q <= q_default;
end

endmodule
