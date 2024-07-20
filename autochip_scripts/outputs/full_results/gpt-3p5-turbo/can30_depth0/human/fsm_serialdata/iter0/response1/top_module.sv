module top_module (
	input clk,
	input in,
	input reset,
	output [7:0] out_byte,
	output done
);

	reg [7:0] shift_reg;
	reg [2:0] state;

	parameter IDLE = 0;
	parameter START_BIT = 1;
	parameter DATA_BITS = 2;
	parameter STOP_BIT = 3;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= IDLE;
			shift_reg <= 8'b0;
		end
		else begin
			case (state)
				IDLE:
					if (!in) begin
						state <= START_BIT;
						shift_reg <= 8'b0;
					end
				START_BIT:
					begin
						if (in)
							state <= DATA_BITS;
					end
				DATA_BITS:
					begin
						shift_reg <= {shift_reg[6:0], in};
						if (shift_reg[7])
							state <= STOP_BIT;
					end
				STOP_BIT:
					begin
						if (in)
							state <= IDLE;
						else begin
							out_byte <= shift_reg;
							state <= IDLE;
							done <= 1'b1;
						end
					end
			endcase
		end
	end

endmodule
