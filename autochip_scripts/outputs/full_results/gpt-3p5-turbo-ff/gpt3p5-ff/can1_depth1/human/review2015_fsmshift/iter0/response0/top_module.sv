module top_module(
	input clk,
	input reset,
	output shift_ena);

	reg [3:0] counter;
	reg shift_ena;
	reg previous_reset;

	always @(posedge clk) begin
		if (reset && ~previous_reset) begin
			counter <= 4;
		end

		if (counter > 0) begin
			shift_ena <= 1;
			counter <= counter - 1;
		end else begin
			shift_ena <= 0;
		end

		previous_reset <= reset;
	end
endmodule
