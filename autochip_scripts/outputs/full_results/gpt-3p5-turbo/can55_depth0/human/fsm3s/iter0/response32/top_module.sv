module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);
	
	// Define states
	typedef enum logic [1:0] {A, B, C, D} state_type;
	reg [1:0] current_state, next_state;
	
	always @(posedge clk or posedge reset) begin
		if (reset)
			current_state <= A;
		else
			current_state <= next_state;
	end
	
	// Define next state logic and output logic based on current state and input
	always @(current_state, in) begin
		case (current_state)
			A: begin
				next_state = in ? B : A;
				out = 0;
			end
			B: begin
				next_state = in ? B : C;
				out = 0;
			end
			C: begin
				next_state = in ? D : A;
				out = 0;
			end
			D: begin
				next_state = in ? B : C;
				out = 1;
			end
		endcase
	end
endmodule
