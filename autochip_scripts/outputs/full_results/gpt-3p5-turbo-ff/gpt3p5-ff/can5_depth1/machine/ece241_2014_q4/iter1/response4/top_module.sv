module top_module (
	input clk,
	input x,
	output reg z
);

reg [2:0] s = 3'b0;

always @(posedge clk) begin
	// Statement 1
	s[2] <= s[1] ^ x;
	s[0] <= x;
	
	// Statement 2
	s[1] <= ~s[1] & x;

	// Statement 3
	s[0] <= ~s[0] | x;

	// Assign output z
	assign z = ~|s; // Move this assignment inside the always block
end

endmodule
