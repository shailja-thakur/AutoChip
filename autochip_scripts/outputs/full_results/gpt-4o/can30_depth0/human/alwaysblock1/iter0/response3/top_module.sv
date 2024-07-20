module top_module(
	input a, 
	input b,
	output out_assign,
	output reg out_alwaysblock
);

	// AND operation using assign statement
	assign out_assign = a & b;

	// AND operation using combinational always block
	always @(*) begin
		out_alwaysblock = a & b;
	end

endmodule
