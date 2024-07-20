module top_module(
	input clk,
	input reset,
	output shift_ena);

	reg [2:0] state;
	reg [3:0] counter;

	parameter IDLE = 0;
	parameter RESET = 1;
	parameter SHIFT_ENA = 2;

	always @(posedge clk) begin
		if (reset) begin
			state <= RESET;
			counter <= 0;
			shift_ena <= 1;
		end else begin
			case (state)
				IDLE:
					begin
						if (<<add your condition for detecting the proper bit pattern>>) begin
							state <= SHIFT_ENA;
							counter <= 4;
							shift_ena <= 1;
						end else begin
							state <= IDLE;
							counter <= 0;
							shift_ena <= 0;
						end
					end
				RESET:
					begin
						state <= IDLE;
						counter <= 0;
						shift_ena <= 0;
					end
				SHIFT_ENA:
					begin
						if (counter == 0) begin
							state <= IDLE;
							counter <= 0;
							shift_ena <= 0;
						end else begin
							state <= SHIFT_ENA;
							counter <= counter - 1;
							shift_ena <= 1;
						end
					end
			endcase
		end
	end

endmodule
