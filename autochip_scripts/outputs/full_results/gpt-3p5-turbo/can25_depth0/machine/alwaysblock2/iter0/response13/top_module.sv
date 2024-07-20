module top_module(
	input clk,
	input a,
	input b,
	output out_assign,
	output reg out_always_comb,
	output reg out_always_ff
);
	//assign out_assign with XOR operation
	assign out_assign = a ^ b;
	
	//always comb block to assign out_always_comb with out_assign
	always @* begin
		out_always_comb = out_assign;
	end
	
	//always ff block to assign out_always_ff with out_assign on rising edge of clk
	always @(posedge clk) begin
		out_always_ff <= out_assign;
	end
	
endmodule
