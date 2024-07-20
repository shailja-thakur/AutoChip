module top_module (
	input clk,
	input x,
	output z
);

reg [2:0] s = 3'b000; // Define and initialize register s

always @(posedge clk) begin
	// Statement 1
	s[2] <= s[1] ^ x; // Exclusive OR x with MSB of s
	s[0] <= x; // Assign x to LSB of s

	// Statement 2
	s[1] <= ~s[1] & x; // Apply NOT operator to middle bit of s and AND it with x

	// Statement 3
	s[0] <= ~s[0] | x; // Apply NOT operator to LSB of s and OR it with x
end

assign z = ~(s[2] | s[1] | s[0]); // Apply OR operator to all bits of s, then apply NOT operator to the result and assign it to output z

endmodule
