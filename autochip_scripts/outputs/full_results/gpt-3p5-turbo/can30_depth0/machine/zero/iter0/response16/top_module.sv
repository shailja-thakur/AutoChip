module top_module(
	output reg zero);   // Adding 'reg' keyword to specify that 'zero' is a register

	always @(*)    // Adding always block to assign constant value
	begin
		zero = 0;   // Assigning 'zero' with the constant value 0
	end

endmodule
