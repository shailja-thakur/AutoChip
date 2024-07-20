module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

	// State definition
	typedef enum reg [1:0] {
		A = 2'b00,
		B = 2'b01,
		C = 2'b10,
		D = 2'b11
	} state_t;
	
	state_t current_state, next_state;
	
	// Transition logic
	always @(*) begin
		case (current_state)
			A: begin
				if (in)
					next_state = B;
				else
					next_state = A;
			end
			B: begin
				if (in)
					next_state = B;
				else
					next_state = C;
			end
			C: begin
				if (in)
					next_state = D;
				else
					next_state = A;
			end
			D: begin
				if (in)
					next_state = B;
				else
					next_state = C;
			end
			default: next_state = A;
		endcase
	end
	
	// State flip-flops
	always @(posedge clk or posedge reset) begin
		if (reset)
			current_state <= A;
		else
			current_state <= next_state;
	end
	
	// Output logic
	always @(*) begin
		case (current_state)
			D: out = 1;
			default: out = 0;
		endcase
	end

endmodule
