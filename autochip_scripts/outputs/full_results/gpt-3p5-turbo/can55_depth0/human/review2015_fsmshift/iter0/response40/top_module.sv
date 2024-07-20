module top_module(
	input clk,
	input reset,
	output shift_ena);

	reg [3:0] counter;
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			counter <= 0;
			shift_ena <= 1;
		end else if (counter < 4) begin
			counter <= counter + 1;
			shift_ena <= 1;
		end else begin
			shift_ena <= 0;
		end
	end

endmodule
