module top_module(
	input clk,
	input reset,
	output shift_ena);

	// Declare internal signals
	reg [2:0] count;
	reg enable_shift;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			// Reset the shift register enable signal and counter
			enable_shift <= 1'b1;
			count <= 3'b0;
		end else begin
			// Check the bit pattern and control the enable signal
			if (count == 3'b100) begin
				enable_shift <= 1'b0;
			end else begin
				enable_shift <= 1'b1;
				count <= count + 1'b1;
			end
		end
	end

	assign shift_ena = enable_shift;

endmodule
