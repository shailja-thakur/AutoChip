module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg [23:0] out_bytes,
	output reg done
);

	// State declaration
	typedef enum logic [1:0] {
		BYTE1 = 2'b00,
		BYTE2 = 2'b01,
		BYTE3 = 2'b10,
		DONE  = 2'b11
	} state_t;

	reg [1:0] state, next_state;
	reg [23:0] out_bytes_temp;

	// State machine for state transitions
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= BYTE1;
			out_bytes_temp <= 24'b0;
			done <= 1'b0;
		end else begin
			state <= next_state;
			out_bytes_temp <= (state != BYTE1 && state != DONE) ? (out_bytes_temp << 8) | in : out_bytes_temp;
			if (next_state == DONE)
				out_bytes <= out_bytes_temp;
		end
	end

	// Next state logic
	always @(*) begin
		next_state = state;
		done = 1'b0;
		case (state)
			BYTE1: begin
				if (in[2])
					next_state = BYTE2;
			end
			BYTE2: begin
				next_state = BYTE3;
			end
			BYTE3: begin
				next_state = DONE;
			end
			DONE: begin
				done = 1'b1;
				if (!in[2])
					next_state = BYTE1;
			end
		endcase
	end

endmodule
