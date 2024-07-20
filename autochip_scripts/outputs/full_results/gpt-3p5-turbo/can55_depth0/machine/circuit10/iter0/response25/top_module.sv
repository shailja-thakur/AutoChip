module top_module (
	input clk,
	input a,
	input b,
	output q,
	output state
);

reg [1:0] c;
assign q = a ^ b ^ c;
assign state = c;

always @(posedge clk)
begin
	c <= (a & b) | (a & c) | (b & c);
end

endmodule
