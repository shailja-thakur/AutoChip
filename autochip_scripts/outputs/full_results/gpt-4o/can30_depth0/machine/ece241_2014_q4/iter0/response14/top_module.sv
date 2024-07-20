module top_module (
	input clk,
	input x,
	output reg z
);

reg [2:0] s;

initial begin
	s = 3'b000;
end

always @(posedge clk) begin
	// Statement 1
	s[2] = s[2] ^ x;
	// Statement 2
	s[1] = ~(s[1] & x);
	// Statement 3
	s[0] = ~s[0] | x;
end

always @(*) begin
	z = ~|s;
end

endmodule
