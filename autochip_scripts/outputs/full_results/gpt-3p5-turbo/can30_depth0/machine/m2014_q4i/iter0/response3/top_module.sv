module top_module(
	output reg out);  // Adding "reg" keyword to specify that the output is a register
	always @(posedge clk)  // Adding a clock input to make the module more useful and realistic
	begin
		out <= 1'b0;  // Assigning the output port with a constant value of 0
	end
endmodule
