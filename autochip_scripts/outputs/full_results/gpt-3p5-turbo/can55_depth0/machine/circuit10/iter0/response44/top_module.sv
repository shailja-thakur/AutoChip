module top_module (
	input clk,
	input a,
	input b,
	output reg q,
	output reg state
);

reg c;

always @(posedge clk) begin
	c <= (a & b) | (a & c) | (b & c); // calculate value of c on each rising edge of clock
end

assign q = a ^ b ^ c; // calculate output q as logical XOR of a, b, and c
assign state = c; // assign output state as value of c

endmodule
