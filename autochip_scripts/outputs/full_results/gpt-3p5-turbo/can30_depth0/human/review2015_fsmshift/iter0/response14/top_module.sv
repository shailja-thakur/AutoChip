module top_module(
	input clk,
	input reset,
	output reg shift_ena); // Declare shift_ena as a reg output

	reg [3:0] counter; // Counter to keep track of clock cycles
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			counter <= 0; // Reset the counter
			shift_ena <= 1; // Enable for 4 cycles during reset
		end else begin
			if (counter < 4) begin
				counter <= counter + 1; // Increment the counter
				shift_ena <= 1; // Enable shift register
			end else begin
				shift_ena <= 0; // Disable shift register
			end
		end
	end
endmodule
