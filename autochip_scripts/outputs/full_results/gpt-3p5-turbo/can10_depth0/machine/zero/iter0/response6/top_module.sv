module top_module(
	output reg zero); // Add reg keyword for output signal

	// Assign constant value to output signal
	always @(*) begin
		zero = 0;
	end
endmodule
