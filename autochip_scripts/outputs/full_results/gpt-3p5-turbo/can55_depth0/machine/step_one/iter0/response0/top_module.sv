module top_module(
	output reg one); // add reg keyword to declare 'one' as a registered output

	always @(*) // change to combinational logic
	begin
		one = 1'b1; // assign constant value to 'one'
	end

endmodule
