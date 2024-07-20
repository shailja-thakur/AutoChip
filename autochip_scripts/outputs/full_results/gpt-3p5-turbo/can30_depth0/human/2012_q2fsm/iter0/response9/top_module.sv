module top_module (
	input clk,	// Clock signal
	input reset,	// Reset signal
	input w,		// Input signal
	output z		// Output signal
);

	// Define states A, B, C, D, E, and F
	parameter A = 3'b000;
	parameter B = 3'b001;
	parameter C = 3'b010;
	parameter D = 3'b011;
	parameter E = 3'b100;
	parameter F = 3'b101;

	reg [2:0] current_state, next_state;

	// State transition table
	always @(current_state, w) begin
		case (current_state)
			A: if (w) next_state = B;
			   else next_state = A;
			B: if (w) next_state = C;
			   else next_state = D;
			C: if (w) next_state = E;
			   else next_state = D;
			D: if (w) next_state = F;
			   else next_state = A;
			E: if (w) next_state = E;
			   else next_state = D;
			F: if (w) next_state = C;
			   else next_state = D;
		endcase
	end

	// State flip-flops
	always @(posedge clk or posedge reset) begin
		if (reset)
			current_state <= A;
		else
			current_state <= next_state;
	end

	// FSM output
	always @(current_state) begin
		case (current_state)
			A: z = 1'b0;
			B: z = 1'b0;
			C: z = 1'b0;
			D: z = 1'b0;
			E: z = 1'b1;
			F: z = 1'b1;
		endcase
	end

endmodule
