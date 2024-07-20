module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg [23:0] out_bytes,
	output reg done
);

	// State Definitions
	typedef enum logic [1:0] {
		BYTE1 = 2'b00,
		BYTE2 = 2'b01,
		BYTE3 = 2'b10,
		DONE  = 2'b11
	} state_t;

	state_t current_state, next_state;
	reg [23:0] shift_register;

	// State Transition Logic
	always_ff @(posedge clk or posedge reset) begin
		if (reset) begin
			current_state <= BYTE1;
		end else begin
			current_state <= next_state;
		end
	end

	// Next State Logic
	always_comb begin
		case (current_state)
			BYTE1: begin
				if (in[2] == 1)
					next_state = BYTE2;
				else
					next_state = BYTE1;
			end
			BYTE2: 
				next_state = BYTE3;
			BYTE3: 
				next_state = DONE;
			DONE:
				next_state = BYTE1;
			default: 
				next_state = BYTE1;
		endcase
	end

	// Output Logic and Shift Register Update
	always_ff @(posedge clk or posedge reset) begin
		if (reset) begin
			done <= 0;
			shift_register <= 24'b0;
			out_bytes <= 24'b0;
		end else begin
			case (current_state)
				BYTE1:
					shift_register <= {shift_register[15:0], in};
				BYTE2: 
					shift_register <= {shift_register[15:0], in};
				BYTE3: 
					shift_register <= {shift_register[15:0], in};
				DONE: begin
					out_bytes <= shift_register;
					done <= 1;
				end
			endcase
		end
	end

endmodule
