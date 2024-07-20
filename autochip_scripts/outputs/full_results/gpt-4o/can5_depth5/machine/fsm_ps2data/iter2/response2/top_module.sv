module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg [23:0] out_bytes,
	output reg done
);

	// State encoding
	typedef enum logic [1:0] {
		BYTE1 = 2'b00,
		BYTE2 = 2'b01,
		BYTE3 = 2'b10,
		DONE = 2'b11
	} state_t;

	state_t state, next_state;
	reg [23:0] shift_reg;

	// State Transition
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= BYTE1;
		end else begin
			state <= next_state;
		end
	end

	// Next state logic
	always @(*) begin
		case (state)
			BYTE1: if (in[2]) next_state = BYTE2; else next_state = BYTE1;
			BYTE2: next_state = BYTE3;
			BYTE3: next_state = DONE;
			DONE: next_state = BYTE1;
			default: next_state = BYTE1;
		endcase
	end

	// Output logic and shift register update
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			shift_reg <= 24'b0;
			out_bytes <= 24'b0;
			done <= 1'b0;
		end else begin
			case (state)
				BYTE1: begin
					shift_reg <= {shift_reg[15:0], in};
					done <= 1'b0;
				end
				BYTE2: begin
					shift_reg <= {shift_reg[15:0], in};
					done <= 1'b0;
				end
				BYTE3: begin
					shift_reg <= {shift_reg[15:0], in};
					done <= 1'b0;
				end
				DONE: begin
					out_bytes <= shift_reg;
					done <= 1'b1;
				end
			endcase

			// Reset done when transitioning back to BYTE1
			if (next_state == BYTE1 && state == DONE) begin
				done <= 1'b0;
				shift_reg <= 24'b0;  // Clear shift_reg when transitioning back to BYTE1
			end
		end
	end
	
endmodule
