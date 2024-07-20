module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg [23:0] out_bytes,
	output reg done
);

	// State definition
	typedef enum reg [1:0] {
		BYTE1 = 2'b00,
		BYTE2 = 2'b01,
		BYTE3 = 2'b10,
		DONE = 2'b11
	} state_t;

	state_t state, next_state;
	reg [23:0] shift_reg;

	// State transition and output logic
	always @ (posedge clk or posedge reset) begin
		if (reset) begin
			state <= BYTE1;
			shift_reg <= 24'b0;
			out_bytes <= 24'b0;
			done <= 0;
		end else begin
			state <= next_state;
			if (state == DONE) begin
				out_bytes <= shift_reg;
				done <= 1;
			end else begin
				done <= 0;
			end
		end
	end

	always @ (*) begin
		next_state = state; // Default to holding state
		case(state)
			BYTE1: begin
				if (in[2] == 1) begin
					next_state = BYTE2;
				end else begin
					next_state = BYTE1;
				end
			end
			BYTE2: next_state = BYTE3;
			BYTE3: next_state = DONE;
			DONE: next_state = BYTE1;
		endcase
	end

	// Shift logic
	always @ (posedge clk or posedge reset) begin
		if (reset) begin
			shift_reg <= 24'b0;
		end else if (state == BYTE1 || state == BYTE2 || state == BYTE3) begin
			shift_reg <= (shift_reg << 8) | in;
		end
	end

endmodule
