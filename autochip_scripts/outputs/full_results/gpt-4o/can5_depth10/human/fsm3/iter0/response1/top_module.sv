module top_module (
	input clk,
	input in,
	input areset,
	output reg out
);

	// Define state encoding
	typedef enum reg [1:0] {
		STATE_A = 2'd0,
		STATE_B = 2'd1,
		STATE_C = 2'd2,
		STATE_D = 2'd3
	} state_t;
	
	state_t state, next_state;

	// State transition on the clock's positive edge
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= STATE_A; // asynchronous reset
		end else begin
			state <= next_state;
		end
	end

	// Next state and output logic
	always @(*) begin
		case(state)
			STATE_A: begin
				next_state = (in) ? STATE_B : STATE_A;
				out = 1'b0;
			end
			STATE_B: begin
				next_state = (in) ? STATE_B : STATE_C;
				out = 1'b0;
			end
			STATE_C: begin
				next_state = (in) ? STATE_D : STATE_A;
				out = 1'b0;
			end
			STATE_D: begin
				next_state = (in) ? STATE_B : STATE_C;
				out = 1'b1;
			end
			default: begin
				next_state = STATE_A; // default to safe state
				out = 1'b0;
			end
		endcase
	end

endmodule
