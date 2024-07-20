module top_module(
	input clk,
	input reset,
	output shift_ena);

	reg [3:0] state;
	reg shift_ena;

	parameter IDLE = 2'b00;
	parameter COUNTING = 2'b01;
	parameter SHIFTING = 2'b10;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= IDLE;
			shift_ena <= 0;
		end else begin
			case (state)
				IDLE: begin
					shift_ena <= 0;
					if (pattern_detected) begin
						state <= COUNTING;
					end
				end

				COUNTING: begin
					shift_ena <= 1;
					state <= SHIFTING;
				end

				SHIFTING: begin
					shift_ena <= 1;
					state <= IDLE;
				end
			endcase
		end
	end

	// Logic to detect the pattern goes here
	// You can replace the "pattern_detected" condition with your pattern detection logic

endmodule
