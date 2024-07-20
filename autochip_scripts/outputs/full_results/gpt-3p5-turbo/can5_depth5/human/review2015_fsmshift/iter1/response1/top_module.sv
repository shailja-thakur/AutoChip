module top_module(
	input clk,
	input reset,
	output shift_ena);

	reg [3:0] count;

	always @(posedge clk) begin
		if (reset)
			count <= 4'b1111; // Set initial value to 15 instead of 0
		else if (count < 4'b0101)
			count <= count + 1;
		else
			count <= count; // Remove unnecessary assignment
	end

	assign shift_ena = (count == 4'b0100); // Change the condition to detect the proper bit pattern

endmodule
