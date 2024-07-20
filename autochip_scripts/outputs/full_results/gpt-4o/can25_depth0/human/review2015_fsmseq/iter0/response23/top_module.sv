module top_module(
	input clk,
	input reset,
	input data,
	output reg start_shifting);

	// State encoding
	typedef enum reg [2:0] {
		IDLE = 3'b000,
		S1 = 3'b001, // Found '1'
		S2 = 3'b010, // Found '11'
		S3 = 3'b011, // Found '110'
		S4 = 3'b100  // Found '1101'
	} state_t;
	
	state_t current_state, next_state;
	
	always @(posedge clk) begin
		if (reset) begin
			current_state <= IDLE;
			start_shifting <= 0;
		end else begin
			current_state <= next_state;
			if (next_state == S4) begin
				start_shifting <= 1;
			end
		end
	end
	
	always @(*) begin
		case (current_state)
			IDLE: next_state = data ? S1 : IDLE;
			S1: next_state = data ? S2 : IDLE;
			S2: next_state = data ? S2 : S3;
			S3: next_state = data ? S4 : IDLE;
			S4: next_state = S4;
			default: next_state = IDLE;
		endcase
	end
	
endmodule
