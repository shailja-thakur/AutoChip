module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg [23:0] out_bytes,
	output reg done
);

	// Define states
	typedef enum logic [1:0] {
		BYTE1 = 2'b00,
		BYTE2 = 2'b01,
		BYTE3 = 2'b10,
		DONE  = 2'b11
	} state_t;

	state_t state, next_state;
	reg [23:0] shift_register;

	// State transition logic
	always_ff @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= BYTE1;
		end else begin
			state <= next_state;
		end
	end

	// Next state logic
	always_comb begin
		case (state)
			BYTE1: next_state = (in[2] == 1'b1) ? BYTE2 : BYTE1;
			BYTE2: next_state = BYTE3;
			BYTE3: next_state = DONE;
			DONE:  next_state = BYTE1;
			default: next_state = BYTE1;
		endcase
	end

	// Output and register update logic
	always_ff @(posedge clk or posedge reset) begin
		if (reset) begin
			shift_register <= 24'b0;
			out_bytes <= 24'b0;
			done <= 1'b0;
		end else begin
			case (state)
				BYTE1: if (in[2] == 1'b1) shift_register <= {shift_register[15:0], in};
				BYTE2: shift_register <= {shift_register[15:0], in};
				BYTE3: shift_register <= {shift_register[15:0], in};
				DONE: begin
					out_bytes <= shift_register;
					done <= 1'b1;
				end
			endcase

			if (state != DONE) begin
				done <= 1'b0;
			end
		end
	end

endmodule
