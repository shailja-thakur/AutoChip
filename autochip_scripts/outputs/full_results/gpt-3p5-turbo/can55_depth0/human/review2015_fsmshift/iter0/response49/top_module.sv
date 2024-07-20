module top_module(
	input clk,
	input reset,
	output shift_ena);

	reg [1:0] state;
	parameter IDLE = 2'b00;
	parameter SHIFT_ENA = 2'b01;
	parameter SHIFT_DIS = 2'b10;

	always @(posedge clk) begin
		if (reset) begin
			shift_ena <= 1'b0;
			state <= IDLE;
		end else begin
			case (state)
				IDLE: begin
					shift_ena <= 1'b0;
					if (shift_pattern_detected())
						state <= SHIFT_ENA;
				end
				SHIFT_ENA: begin
					shift_ena <= 1'b1;
					state <= SHIFT_DIS;
				end
				SHIFT_DIS: begin
					shift_ena <= 1'b0;
					state <= IDLE;
				end
			endcase
		end
	end

	function shift_pattern_detected;
		input [7:0] data;
		begin
			// Put your logic for shift pattern detection here
			// Return 1 if pattern is detected, 0 otherwise
		end
	endfunction

endmodule
