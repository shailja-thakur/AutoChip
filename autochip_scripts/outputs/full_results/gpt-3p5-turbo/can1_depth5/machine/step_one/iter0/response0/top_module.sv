module top_module(
	output reg one); // add 'reg' keyword to specify that 'one' is a register

	always @(*) // use always @(*) for combinational logic
	begin
		one = 1'b1; // assign constant value 1'b1 to 'one'
	end

endmodule
