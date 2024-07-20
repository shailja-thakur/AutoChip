module top_module (
	input clk,
	input x,
	output reg z
);
	reg [2:0] s = 3'b000;

	always @(posedge clk) begin
		s[2] <= s[2] ^ x; // Statement 1: XOR of MSB with x
		s[1] <= s[1] | ~x; // Statement 2: AND of middle bit with NOT x
		s[0] <= s[0] | ~x; // Statement 3: OR of LSB with NOT x
	end

	always @(*) begin
		z = ~(s[2] | s[1] | s[0]); // Assign output z as NOT of OR of all bits of s
	end
endmodule
