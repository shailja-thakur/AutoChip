module top_module(
	input clk,
	input reset,
	output shift_ena);

	reg [2:0] state;
	parameter [2:0] IDLE = 0;
	parameter [2:0] ENABLED = 1;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			shift_ena <= 1'b0;
			state <= IDLE;
		end else begin
			case (state)
				IDLE: begin
					if (/* add condition for proper bit pattern */) begin
						shift_ena <= 1'b1;
						state <= ENABLED;
					end else begin
						shift_ena <= 1'b0;
						state <= IDLE;
					end
				end
				ENABLED: begin
					shift_ena <= 1'b0;
					state <= IDLE;
				end
			endcase
		end
	end
endmodule
