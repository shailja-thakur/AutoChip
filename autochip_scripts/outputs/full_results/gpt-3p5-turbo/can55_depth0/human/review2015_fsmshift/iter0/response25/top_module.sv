module top_module(
	input clk,
	input reset,
	output shift_ena);

	reg [2:0] state;
	reg [3:0] count;

	parameter IDLE = 0;
	parameter CHECK_PATTERN = 1;
	parameter SHIFT_ENA = 2;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= IDLE;
			count <= 0;
		end else begin
			case (state)
				IDLE:
					begin
						count <= 0;
						if (/* condition to check for bit pattern */) begin
							state <= CHECK_PATTERN;
						end
					end
				CHECK_PATTERN:
					begin
						if (/* condition to check for bit pattern */) begin
							count <= count + 1;
							if (count == 3) begin
								state <= SHIFT_ENA;
							end
						end else begin
							state <= IDLE;
						end
					end
				SHIFT_ENA:
					begin
						count <= count + 1;
						if (count == 3) begin
							state <= IDLE;
						end
					end
			endcase
		end
	end

	assign shift_ena = (state == SHIFT_ENA);

endmodule
