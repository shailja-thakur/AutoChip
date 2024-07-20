module top_module(
	input clk,
	input reset,
	input data,
	output reg start_shifting);

	// State declaration
	enum {STATE_IDLE, STATE_1, STATE_2, STATE_3, STATE_4} state;

	// Register declaration
	reg [3:0] shift_reg;

	always @(posedge clk) begin
		if (reset) begin
			shift_reg <= 4'b0000;
			start_shifting <= 0;
			state <= STATE_IDLE;
		end else begin
			case (state)
				STATE_IDLE:
					if (data) begin
						shift_reg <= {shift_reg[2:0], data};
						if (shift_reg == 4'b1101)
							state <= STATE_1;
					end
				STATE_1:
					shift_reg <= {shift_reg[2:0], data};
					if (shift_reg == 4'b1101) begin
						state <= STATE_2;
						start_shifting <= 1;
					end
				STATE_2:
					shift_reg <= {shift_reg[2:0], data};
					if (shift_reg == 4'b1101) begin
						state <= STATE_3;
						start_shifting <= 1;
					end
				STATE_3:
					shift_reg <= {shift_reg[2:0], data};
					if (shift_reg == 4'b1101) begin
						state <= STATE_4;
						start_shifting <= 1;
					end
				STATE_4:
					shift_reg <= {shift_reg[2:0], data};
					if (shift_reg == 4'b1101)
						start_shifting <= 1;
			endcase
		end
	end
endmodule
