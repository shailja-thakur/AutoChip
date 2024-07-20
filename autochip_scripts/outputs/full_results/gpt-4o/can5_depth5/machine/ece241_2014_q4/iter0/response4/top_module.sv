module top_module (
	input clk,
	input x,
	output reg z
);

	reg [2:0] s = 3'b000;
	
	always @(posedge clk) begin
		s[2] <= x ^ s[2];         // Statement 1: XOR x with MSB of s and assign to MSB of s
		s[1] <= x & ~s[1];        // Statement 2: AND x with NOT of middle bit of s and assign to middle bit of s
		s[0] <= x | ~s[0];        // Statement 3: OR x with NOT of LSB of s and assign to LSB of s
	end

	assign z = ~(|s);           // OR all bits of s, apply NOT operator and assign to z

endmodule
