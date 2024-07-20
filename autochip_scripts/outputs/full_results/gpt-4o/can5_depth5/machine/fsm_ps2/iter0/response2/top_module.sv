module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg done
);

	typedef enum reg [1:0] { BYTE1, BYTE2, BYTE3, DONE } state_t;
	
	state_t current_state, next_state;

	// State machine sequential logic
	always @(posedge clk or posedge reset) begin
		if (reset) 
			current_state <= BYTE1;
		else 
			current_state <= next_state;
	end

	// State machine combinatorial logic
	always @(*) begin
		done = 0;
		case (current_state)
			BYTE1: begin
				if (in[2] == 1) 
					next_state = BYTE2;
				else 
					next_state = BYTE1;
			end
			BYTE2: begin
				next_state = BYTE3;
			end
			BYTE3: begin
				next_state = DONE;
			end
			DONE: begin
				done = 1;
				if (in[2] == 0) 
					next_state = BYTE1;
				else 
					next_state = BYTE2;
			end
			default: next_state = BYTE1;
		endcase
	end
endmodule
