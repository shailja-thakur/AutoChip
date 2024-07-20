module top_module (
	input clk,
	input a,
	input b,
	output q,
	output state
);

// Internal signal declarations
reg c;

// Register for storing value of c
always @(posedge clk) begin
	c <= (a & b) | (a & c) | (b & c);
end

// Assignment for calculating q and state
assign q = a ^ b ^ c;
assign state = c;

endmodule
