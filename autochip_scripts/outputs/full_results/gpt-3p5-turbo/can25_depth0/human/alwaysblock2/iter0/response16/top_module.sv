module top_module(
	input clk,
	input a, 
	input b,
	output out_assign,
	output reg out_always_comb,
	output reg out_always_ff
);

assign out_assign = a ^ b;

always @* begin
	out_always_comb = a ^ b;
end

reg xor_ff;

always @(posedge clk) begin
	xor_ff <= a ^ b;
end

always @* begin
	out_always_ff = xor_ff;
end

endmodule
