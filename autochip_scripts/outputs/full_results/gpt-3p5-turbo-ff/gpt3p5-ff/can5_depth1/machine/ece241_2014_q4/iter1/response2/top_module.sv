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
end

// Fix Assignment
always @* begin
	z = !(s[2] | s[1] | s[0]);
end

endmodule
