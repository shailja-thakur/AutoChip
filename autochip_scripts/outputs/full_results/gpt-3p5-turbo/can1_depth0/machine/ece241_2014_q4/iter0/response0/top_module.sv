module top_module (
	input clk,
	input x,
	output z
);

reg [2:0] s = 3'b0;

always @(posedge clk) begin
	// Statement 1
	s[2] <= s[1] ^ x; // MSB of s is assigned x XORed with the middle bit of s
	s[0] <= x; // LSB of s is assigned the value of x
	
	// Statement 2
	s[1] <= ~s[1] & x; // Middle bit of s is assigned x ANDed with the NOT of the middle bit of s
	
	// Statement 3
	s[0] <= ~s[0] | x; // LSB of s is assigned x ORed with the NOT of the LSB of s
end

assign z = ~(s[2] | s[1] | s[0]); // Output z is assigned the NOT of the OR operation on all bits of s

endmodule
