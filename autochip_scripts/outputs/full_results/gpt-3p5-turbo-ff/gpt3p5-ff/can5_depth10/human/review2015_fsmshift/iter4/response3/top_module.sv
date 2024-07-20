module top_module(
	input clk,
	input reset,
	output reg shift_ena);

	reg [3:0] count;
	reg [1:0] state;

	parameter IDLE = 2'b00;
	parameter COUNTING = 2'b01;
	parameter RESET = 2'b10;

	always @(posedge clk, posedge reset) begin
		if (reset) begin
			count <= 0;
			shift_ena <= 1;
			state <= RESET;
		end else begin
			case(state)
				IDLE: begin
					count <= 0;
					shift_ena <= 1;
					if (input_bit_pattern_valid) begin
						state <= COUNTING;
					end
				end
				COUNTING: begin
					count <= count + 1;
					shift_ena <= 1;
					if (count == 3) begin
						state <= IDLE;
					end
				end
				RESET: begin
					shift_ena <= 0;
					if (!reset) begin
						state <= IDLE;
					end
				end
			endcase
		end
	end

endmodule
