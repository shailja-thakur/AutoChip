module top_module(
	input clk,
	input reset,
	output reg shift_ena);

	reg [2:0] count;
	reg state;

	always @(posedge clk) begin
		if (reset) begin
			count <= 0;
			shift_ena <= 1;
			state <= 1;
		end else begin
			if (state) begin
				if (count < 3) begin
					count <= count + 1;
					shift_ena <= 1;
				end else begin
					shift_ena <= 0;
					state <= 0;
				end
			end else begin
				shift_ena <= 0;
			end
		end
	end

endmodule
