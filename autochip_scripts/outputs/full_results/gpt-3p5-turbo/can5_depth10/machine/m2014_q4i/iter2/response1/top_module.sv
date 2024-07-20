module top_module(
	output reg out);

	initial begin
		#5; // Delay for 5 time units before assigning the output
		out = 0;
		$finish; // Finish the simulation
	end

endmodule
