module top_module(
	input clk,
	input reset,
	output shift_ena);

	reg [2:0] state;

	parameter IDLE = 0;
	parameter RESET = 1;
	parameter ENABLE = 2;

	always @(posedge clk) begin
		if (reset) begin
			state <= RESET;
		end else begin
			case (state)
				IDLE: begin
					if (/* YOUR BIT PATTERN CONDITION */) begin
						state <= ENABLE;
					end
				end
				RESET: begin
					state <= RESET;
				end
				ENABLE: begin
					state <= ENABLE;
				end
				default: begin
					state <= IDLE;
				end
			endcase
		end
	end

	always @(*) begin
		case (state)
			IDLE: begin
				shift_ena = 0;
			end
			RESET: begin
				shift_ena = 1;
			end
			ENABLE: begin
				shift_ena = 1;
			end
			default: begin
				shift_ena = 0;
			end
		endcase
	end
endmodule
