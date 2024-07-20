module top_module(
	input clk,
	input a, 
	input b,
	output out_assign,
	output reg out_always_comb,
	output reg out_always_ff
); 

// Assign Statement
assign out_assign = a ^ b;

// Combinational Always Block
always @(*) begin
	out_always_comb = a ^ b;
end

// Clocked Always Block
always @(posedge clk) begin
	out_always_ff <= a ^ b;
end

endmodule
