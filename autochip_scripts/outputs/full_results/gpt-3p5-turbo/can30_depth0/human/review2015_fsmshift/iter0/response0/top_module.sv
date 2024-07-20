module top_module(
	input clk,
	input reset,
	output shift_ena);

	reg [3:0] counter;
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			counter <= 4'b1111;
		end else if (counter > 0) begin
			counter <= counter - 1;
		end
	end

	always @(posedge clk) begin
		if (counter > 0) begin
			shift_ena <= 1'b1;
		end else begin
			shift_ena <= 1'b0;
		end
	end

endmodule
