module top_module(
	input clk,
	input reset,
	output reg shift_ena);

	reg [3:0] count;
	reg [1:0] state;

	parameter IDLE_STATE = 2'b00;
	parameter SHIFT_ENABLE_STATE = 2'b01;
	parameter RESET_STATE = 2'b10;

	always @(posedge clk) begin
		if (reset) begin
			count <= 0;
			state <= RESET_STATE;
		end else begin
			case (state)
				IDLE_STATE:
					begin
						if (count == 0) begin
							if (/* proper bit pattern is detected */) begin
								count <= 1;
								state <= SHIFT_ENABLE_STATE;
							end
						end else begin
							count <= 0;
						end
					end
				SHIFT_ENABLE_STATE:
					begin
						if (count < 3) begin
							count <= count + 1;
						end else begin
							count <= 0;
							state <= IDLE_STATE;
						end
						shift_ena <= 1;
					end
				RESET_STATE:
					begin
						count <= 0;
						shift_ena <= 1;
						state <= IDLE_STATE;
					end
			endcase
		end
	end

endmodule
