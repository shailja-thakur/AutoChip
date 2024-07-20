module top_module (
	input clk,
	input reset,
	input w,
	output reg z
);

	// State declarations
	typedef enum reg [2:0] {
		A = 3'b000,
		B = 3'b001,
		C = 3'b010,
		D = 3'b011,
		E = 3'b100,
		F = 3'b101
	} state_t;
	
	state_t current_state, next_state;

	// State transition logic
	always @(*) begin
		case (current_state)
			A: begin
				if (w == 1'b0)
					next_state = B;
				else
					next_state = A;
			end
			B: begin
				if (w == 1'b1)
					next_state = D;
				else
					next_state = C;
			end
			C: begin
				if (w == 1'b1)
					next_state = D;
				else
					next_state = E;
			end
			D: begin
				if (w == 1'b1)
					next_state = A;
				else
					next_state = F;
			end
			E: begin
				if (w == 1'b1)
					next_state = D;
				else
					next_state = E;
			end
			F: begin
				if (w == 1'b1)
					next_state = D;
				else
					next_state = C;
			end
			default: next_state = A; // Default state
		endcase
		z = (current_state == E || current_state == F) ? 1'b1 : 1'b0;
	}

	// State flip-flops
	always @(posedge clk or posedge reset) begin
		if (reset)
			current_state <= A;
		else
			current_state <= next_state;
	 end

endmodule
