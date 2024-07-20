module top_module(
	input clk,
	input reset,
	output shift_ena);

	reg [2:0] state;
	reg [1:0] count;

	// Parameter for the desired bit pattern
	parameter [2:0] bit_pattern = 3'b101;

	// State definitions
	parameter IDLE = 0;
	parameter DETECT = 1;
	parameter SHIFT = 2;
	parameter RESET_SHIFT = 3;

	always @(posedge clk) begin
		if (reset) begin
			state <= RESET_SHIFT;
			count <= 2'b0;
		end else begin
			case (state)
				IDLE: begin
					if (in_data == bit_pattern) begin
						state <= DETECT;
						count <= 2'b0;
					end else begin
						state <= IDLE;
					end
				end

				DETECT: begin
					if (count < 4) begin
						state <= DETECT;
						count <= count + 1;
					end else begin
						state <= SHIFT;
						count <= 2'b0;
					end
				end

				SHIFT: begin
					state <= IDLE;
				end

				RESET_SHIFT: begin
					if (count < 4) begin
						state <= RESET_SHIFT;
						count <= count + 1;
					end else begin
						state <= IDLE;
						count <= 2'b0;
					end
				end
			endcase
		end
	end

	// Output assignments
	assign shift_ena = (state == DETECT || state == SHIFT);

endmodule
