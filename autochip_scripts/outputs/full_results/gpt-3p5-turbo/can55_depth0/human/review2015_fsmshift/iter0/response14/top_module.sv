module top_module(
	input clk,
	input reset,
    output reg shift_ena);

	reg [3:0] state;

	parameter [3:0] IDLE = 4'b0000;
	parameter [3:0] DETECT = 4'b0001;
	parameter [3:0] ENABLE = 4'b0010;

	always @(posedge clk) begin
		if (reset) begin
			shift_ena <= 1'b0;
			state <= IDLE;
		end else begin
			case(state)
				IDLE: begin
					shift_ena <= 1'b0;
					if (/* insert condition to detect proper bit pattern */) begin
						state <= DETECT;
					end
				end

				DETECT: begin
					shift_ena <= 1'b1;
					state <= ENABLE;
				end

				ENABLE: begin
					shift_ena <= 1'b1;
					state <= IDLE;
				end

				default: begin
					shift_ena <= 1'b0;
					state <= IDLE;
				end
			endcase
		end
	end

endmodule
