module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg [23:0] out_bytes,
	output reg done
);

	// State Declaration
	typedef enum reg [1:0] {
		IDLE, 
		BYTE1, 
		BYTE2, 
		BYTE3
	} state_t;

	state_t state, next_state;
	reg [23:0] message;

	// State Transition Logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= IDLE;
			message <= 24'b0;
		end else begin
			state <= next_state;
			if (next_state == BYTE1) message[23:16] <= in;
			else if (next_state == BYTE2) message[15:8] <= in;
			else if (next_state == BYTE3) message[7:0] <= in;
		end
	end

	// Next State Logic
	always @(*) begin
		next_state = state;
		done = 1'b0;
		case (state)
			IDLE: begin
				if (in[3] == 1'b1) next_state = BYTE1;
			end
			BYTE1: begin
				next_state = BYTE2;
			end
			BYTE2: begin
				next_state = BYTE3;
			end
			BYTE3: begin
				done = 1'b1;
				next_state = IDLE;
			end
		endcase
		out_bytes = done ? message : 24'b0;
	end

endmodule
