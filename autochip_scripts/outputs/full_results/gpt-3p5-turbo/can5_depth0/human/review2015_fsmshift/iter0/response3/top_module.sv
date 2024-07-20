module top_module(
	input clk,
	input reset,
	output shift_ena);

	reg [2:0] state;
	reg shift_ena_reg;

	parameter IDLE = 0;
	parameter DETECT = 1;
	parameter SHIFT = 2;

	always @(posedge clk) begin
		if (reset) begin
			state <= IDLE;
			shift_ena_reg <= 1'b0;
		end else begin
			case (state)
				IDLE: begin
					if (/* detection condition */) begin
						state <= DETECT;
						shift_ena_reg <= 1'b1;
					end
				end
				DETECT: begin
					state <= SHIFT;
					shift_ena_reg <= 1'b1;
				end
				SHIFT: begin
					state <= IDLE;
					shift_ena_reg <= 1'b0;
				end
			endcase
		end
	end

	assign shift_ena = shift_ena_reg;

endmodule
