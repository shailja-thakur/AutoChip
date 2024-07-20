module top_module(
	output reg one); // Added reg keyword for output signal

	always @(*) // Added sensitivity list
		begin
			one = 1; // Set output signal value to 1
		end
endmodule
