module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output [3:1] g
);

	// State encoding
	typedef enum reg [1:0] {
		A = 2'b00,
		B = 2'b01,
		C = 2'b10,
		D = 2'b11
	} state_t;

	state_t state, next_state;

	// State register
	always @(posedge clk or negedge resetn) begin
		if (!resetn)
			state <= A;  // Reset state to A
		else
			state <= next_state;  // Update state
	end

	// Next state logic
	always @(*) begin
		case (state)
			A: begin
				if (r[1])
					next_state = B;
				else if (r[2])
					next_state = C;
				else if (r[3])
					next_state = D;
				else
					next_state = A;  // Default transition stays in state A
			end
			B: begin
				if (r[1])
					next_state = B;
				else
					next_state = A;  // Release resource and go back to A
			end
			C: begin
				if (r[2])
					next_state = C;
				else
					next_state = A;  // Release resource and go back to A
			end
			D: begin
				next_state = A;  // Always goes back to A from D
			end
			default: next_state = A;  // Default state
		endcase
	end

	// Output logic
	assign g = (state == B) ? 3'b001 :
	           (state == C) ? 3'b010 :
			   (state == D) ? 3'b100 : 3'b000;

endmodule
