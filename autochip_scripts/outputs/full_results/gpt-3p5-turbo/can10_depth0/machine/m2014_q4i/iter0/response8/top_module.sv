module top_module(
	output reg out); // Use reg datatype for output port

	always @(*) // Use combinational logic
	begin
		out = 0; // Assign output port to constant value 0
	end
	
endmodule
