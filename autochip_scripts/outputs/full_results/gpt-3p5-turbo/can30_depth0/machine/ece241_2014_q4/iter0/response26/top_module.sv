module top_module (
	input clk,
	input x,
	output z
);

reg [2:0] s;
assign z = ~(s[2] | s[1] | s[0]);

always @(posedge clk) begin
	s[2] <= x ^ s[2]; 
	s[1] <= ~s[1] & x;
	s[0] <= ~s[0] | x;
end

endmodule
