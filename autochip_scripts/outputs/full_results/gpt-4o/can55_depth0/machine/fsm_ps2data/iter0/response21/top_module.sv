module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg [23:0] out_bytes,
	output reg done
);

	// State declaration
	typedef enum reg [1:0] {
		BYTE1 = 2'b00,
		BYTE2 = 2'b01,
		BYTE3 = 2'b10,
		DONE  = 2'b11
	} state_t;

	state_t state, next_state;

	// Sequential: update the current state and out_bytes register on the clock edge
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= BYTE1;
			out_bytes <= 24'b0;
		end else begin
			state <= next_state;
			if (state != DONE) begin
				out_bytes <= {out_bytes[15:0], in};  // shift left by 8 bits and insert new input
			end
		end
	end

	// Combinational: determine the next state and the done signal
	always @(*) begin
		next_state = state;  // default state is to remain in current state
		done = 0;
		case (state)
			BYTE1: begin
				if (in[2] == 1'b1) begin
					next_state = BYTE2;
				end
			end
			BYTE2: begin
				next_state = BYTE3;
			end
			BYTE3: begin
				next_state = DONE;
			end
			DONE: begin
				next_state = BYTE1;
				done = 1'b1;
			end
			default: begin
				next_state = BYTE1;
			end
		endcase
	end

endmodule
