module top_module(
	output reg zero); // Making the output a reg type
	always @(posedge clk) // Adding a clock to the module
		zero <= 0; // Assigning the output zero to 0
endmodule
