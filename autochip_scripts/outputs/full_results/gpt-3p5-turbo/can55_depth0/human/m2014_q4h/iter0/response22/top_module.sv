module top_module(
	input in,
	output reg out); // added "reg" keyword to define out as a register

	always @(*) // added sensitivity list
	begin
		out = in; // assigns the value of input to output
	end

endmodule
