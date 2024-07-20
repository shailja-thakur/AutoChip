module top_module (
	input clk,
	input x,
	output z
);

reg [2:0] s;
reg [2:0] s_next;

always @(posedge clk) begin
	// Statement 1
	s_next[2] = s[1] ^ x;
	s_next[1] = ~s[1] & x;
	s_next[0] = ~s[0] | x;
	
	s <= s_next;
end

assign z = ~(s[2] | s[1] | s[0]);

endmodule
