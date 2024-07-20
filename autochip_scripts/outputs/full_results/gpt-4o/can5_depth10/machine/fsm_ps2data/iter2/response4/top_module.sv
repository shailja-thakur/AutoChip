module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg [23:0] out_bytes,
	output reg done
);

	// State Definitions
	typedef enum reg [1:0] {BYTE1, BYTE2, BYTE3, DONE} state_t;
	state_t state, next_state;

	// Shift register
	reg [23:0] shift_reg;

	// State Machine
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= BYTE1;
			shift_reg <= 24'b0;
			out_bytes <= 24'b0;
			done <= 1'b0;
		end else begin
			state <= next_state;
			case (state)
				BYTE1, BYTE2, BYTE3: shift_reg <= {shift_reg[15:0], in}; // Shift input into register
				DONE: out_bytes <= shift_reg; // Set out_bytes when done
			endcase
		end
	end

	// Next state logic
	always @(*) begin
		done = 1'b0;
		case(state)
			BYTE1: begin
				if (in[2] == 1) next_state = BYTE2;
				else next_state = BYTE1;
			end
			BYTE2: next_state = BYTE3;
			BYTE3: next_state = DONE;
			DONE: begin
				done = 1'b1;
				if (in[2] == 0) next_state = BYTE1;
				else next_state = DONE;
			end
		endcase
	end

endmodule
