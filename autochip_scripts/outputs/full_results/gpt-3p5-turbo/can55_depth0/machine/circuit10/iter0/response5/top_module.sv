module top_module (
	input clk,
	input a,
	input b,
	output q,
	output state
);

reg [1:0] c;
assign c = (a & b) | (a & c) | (b & c);

always @(posedge clk) begin
	q <= a ^ b ^ c;
	state <= c;
end

endmodule
