module top_module(
	input clk,
	input reset,
	output shift_ena);

	reg [2:0] state;
	parameter IDLE = 0;
	parameter SHIFT_ENABLE = 1;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			shift_ena <= 0;
			state <= IDLE;
		else begin
			case(state)
				IDLE: begin
					if (bit_pattern_detected) begin
						state <= SHIFT_ENABLE;
						shift_ena <= 1;
					end
				end
				SHIFT_ENABLE: begin
					if (counter >= 3) begin
						state <= IDLE;
						shift_ena <= 0;
					end
				end
			endcase
		end
	end

endmodule
