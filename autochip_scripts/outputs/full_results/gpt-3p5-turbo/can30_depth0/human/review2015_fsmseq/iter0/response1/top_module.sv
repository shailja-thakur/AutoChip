module top_module(
	input clk,
	input reset,
	input data,
	output reg start_shifting);

	// Define states
	enum {STATE_IDLE, STATE_WAIT1, STATE_WAIT2, STATE_WAIT3, STATE_FOUND} state;

	// Registers
	reg [3:0] shift_reg;
	reg [1:0] count;

	// Output register
	assign start_shifting = (state == STATE_FOUND);

	always @(posedge clk) begin
		if (reset) begin
			state <= STATE_IDLE;
			shift_reg <= 4'b0;
			count <= 2'b0;
		end else begin
			case (state)
				STATE_IDLE: begin
					if (data) begin
						state <= STATE_WAIT1;
						shift_reg <= {shift_reg[2:0], data};
					end
				end
				STATE_WAIT1: begin
					state <= STATE_WAIT2;
					shift_reg <= {shift_reg[2:0], data};
				end
				STATE_WAIT2: begin
					state <= STATE_WAIT3;
					shift_reg <= {shift_reg[2:0], data};
				end
				STATE_WAIT3: begin
					if (!data) begin
						state <= STATE_IDLE;
						shift_reg <= {shift_reg[2:0], data};
					end else begin
						count <= count + 1;
						shift_reg <= {shift_reg[2:0], data};
						if (count == 2'b11) begin
							state <= STATE_FOUND;
						end
					end
				end
				STATE_FOUND: begin
					if (data) begin
						state <= STATE_WAIT1;
						shift_reg <= {shift_reg[2:0], data};
					end
				end
			endcase
		end
	end
endmodule
