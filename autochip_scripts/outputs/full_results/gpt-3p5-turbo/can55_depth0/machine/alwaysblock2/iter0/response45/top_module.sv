module top_module(
	input clk,
	input a, 
	input b,
	output out_assign,
	output reg out_always_comb,
	output reg out_always_ff
); 

	// assign out_assign port with XOR operation on a and b 
	assign out_assign = a ^ b;

	// always block triggered whenever the values of a and b change
	always @(a or b)
	begin
		out_always_comb <= out_assign;
	end

	// always block triggered on the rising edge of clk
	always @(posedge clk)
	begin
		out_always_ff <= out_assign;
	end

endmodule
