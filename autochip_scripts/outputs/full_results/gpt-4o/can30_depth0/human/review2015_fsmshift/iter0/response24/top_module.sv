module top_module(
	input clk,
	input reset,
	output reg shift_ena);

	reg [2:0] counter;

	always @(posedge clk) begin
		if (reset) begin
			counter <= 3'b100; // Initialize counter to 4 (3-bit wide)
			shift_ena <= 1'b1; // Shift enable is high when reset
		end else if (counter > 0) begin
			counter <= counter - 1;
			if(counter == 1) begin
				shift_ena <= 1'b0; // Disable shift enable after 4 cycles
			end
		end
	end

endmodule
