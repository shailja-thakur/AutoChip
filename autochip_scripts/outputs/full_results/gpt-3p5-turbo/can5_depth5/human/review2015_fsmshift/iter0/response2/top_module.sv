module top_module(
	input clk,
	input reset,
	output reg shift_ena);

	reg [1:0] state;
	reg [3:0] count;

	parameter IDLE = 2'b00;
	parameter ENABLE = 2'b01;
	parameter RESET = 2'b10;

	always @(posedge clk) begin
		if (reset) begin
			state <= RESET;
			count <= 0;
			shift_ena <= 1;
		end else begin
			case (state)
				IDLE: begin
					if (<<add condition for bit pattern detection>>) begin
						state <= ENABLE;
						count <= 0;
						shift_ena <= 1;
					end
				end

				ENABLE: begin
					if (count < 3) begin
						count <= count + 1;
						shift_ena <= 1;
					end else begin
						state <= IDLE;
						shift_ena <= 0;
					end
				end

				RESET: begin
					shift_ena <= 1;
					state <= IDLE;
				end
			endcase
		end
	end
endmodule
