module top_module(
	input clk,
	input reset,
	output reg shift_ena);

	reg [2:0] counter;

	always @(posedge clk) begin
		if (reset) begin
			counter <= 3'b100;
		end else if (counter > 0) begin
			counter <= counter - 1;
		end
	end

	always @(posedge clk) begin
		if (reset) begin
			shift_ena <= 1;
		end else if (counter > 0) begin
			shift_ena <= 1;
		end else begin
			shift_ena <= 0;
		end
	end

endmodule
