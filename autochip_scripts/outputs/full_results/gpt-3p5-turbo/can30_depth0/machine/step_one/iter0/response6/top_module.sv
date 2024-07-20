module top_module(
	output reg one // Add "reg" to specify that "one" is a reg type
	);
	
	always @(*) // Use '@(*)' for combinational logic
	begin
		one = 1'b1; // Assign "one" with a constant value of 1'b1
	end
	
endmodule
