module top_module(
	input a, 
	input b,
	output out_assign,
	output reg out_alwaysblock
);

// Using an assign statement to build the AND gate
assign out_assign = a & b;

// Using a combinational always block to build the AND gate
always @*
	begin
		out_alwaysblock = a & b;
	end

endmodule
