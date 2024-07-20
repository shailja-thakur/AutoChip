module top_module(
	output reg one);  // Declaration of register 'one'

	always @(*)  // Combinational always block
	begin
		one = 1'b1;  // Assign logic high value to 'one'
	end

endmodule
