module top_module(
	input clk,
	input reset,
	output shift_ena);

	reg [2:0] state;
	reg [3:0] cnt;

	parameter IDLE = 0;
	parameter COUNTING = 1;
	parameter SHIFT_ENA = 2;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= IDLE;
			cnt <= 0;
			shift_ena <= 1;
		end else begin
			case(state)
				IDLE: begin
					cnt <= 0;
					shift_ena <= 0;
					if (bit_pattern_detected) begin
						state <= COUNTING;
						shift_ena <= 1;
					end
				end
				COUNTING: begin
					cnt <= cnt + 1;
					shift_ena <= 1;
					if (cnt == 3) begin
						state <= SHIFT_ENA;
						shift_ena <= 1;
					end
				end
				SHIFT_ENA: begin
					cnt <= 0;
					shift_ena <= 0;
					state <= IDLE;
				end
			endcase
		end
	end

endmodule
