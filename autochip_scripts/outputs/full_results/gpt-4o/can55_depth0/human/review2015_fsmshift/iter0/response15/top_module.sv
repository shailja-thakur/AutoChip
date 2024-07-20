module top_module(
	input clk,
	input reset,
	output reg shift_ena);

	reg [2:0] shift_counter;

	always @(posedge clk) begin
		if (reset) begin
			shift_counter <= 3'b011; // Set counter for 4 cycles (increment starting from 3'b011 to 3'b000)
			shift_ena <= 1'b1;
		end else if (shift_counter != 3'b000) begin
			shift_counter <= shift_counter - 1;
			shift_ena <= 1'b1;
		end else begin
			shift_ena <= 1'b0;
		end
	end

endmodule
