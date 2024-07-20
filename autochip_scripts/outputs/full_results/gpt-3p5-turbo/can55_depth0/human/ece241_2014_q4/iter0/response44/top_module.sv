module top_module (
	input clk,
	input x,
	output z
);
	reg a_dff;
	reg b_dff;
	reg c_dff;
	
	assign a = x ^ a_dff;
	assign b = ~b_dff & x;
	assign c = ~c_dff | x;
	
	assign z = ~(a_dff ^ b_dff ^ c_dff);
	
	always @(posedge clk) begin
		a_dff <= a;
		b_dff <= b;
		c_dff <= c;
	end
	
endmodule
