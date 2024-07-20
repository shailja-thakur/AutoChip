module top_module (
	input clk,
	input reset,
	input w,
	output z
);

// State enumeration
typedef enum logic [2:0] {
	A,
	B,
	C,
	D,
	E,
	F
} state_t;

// State variables
reg [2:0] current_state;
reg [2:0] next_state;

// Flip-flop to store the current state
always @(posedge clk or posedge reset) begin
	if (reset)
		current_state <= A;
	else
		current_state <= next_state;
end

// State transition logic
always @(current_state or w) begin
	case (current_state)
		A: begin
			if (w)
				next_state = B;
			else
				next_state = A;
		end
		B: begin
			if (w)
				next_state = C;
			else
				next_state = D;
		end
		C: begin
			if (w)
				next_state = E;
			else
				next_state = D;
		end
		D: begin
			if (w)
				next_state = F;
			else
				next_state = A;
		end
		E: begin
			if (w)
				next_state = E;
			else
				next_state = D;
		end
		F: begin
			if (w)
				next_state = C;
			else
				next_state = D;
		end
	endcase
end

// Output assignment
always @(current_state) begin
	case (current_state)
		A, B, C, D: z = 0;
		E, F: z = 1;
	endcase
end

endmodule
