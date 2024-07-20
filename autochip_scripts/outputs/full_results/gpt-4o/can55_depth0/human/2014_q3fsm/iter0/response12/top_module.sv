module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

	// State definition
	typedef enum reg [1:0] {
		A = 2'b00,
		B = 2'b01,
		C = 2'b10,
		D = 2'b11
	} state_t;

	state_t state, next_state;
	reg [1:0] w_count; // Counter for 'w' being 1

	// Sequential block for state transitions and counter updates
	always @(posedge clk) begin
		if (reset) begin
			state <= A;
			w_count <= 0;
			z <= 0;
		end else begin
			state <= next_state;
			if (state == B || state == C || state == D) begin
				if (w) 
					w_count <= w_count + 1;
				else 
					w_count <= w_count;
			end
			if (next_state == A)
				w_count <= 0;
		end
	end

	// Combinational block for next state logic
	always @(*) begin
		next_state = state;
		z = 0;
		case (state)
			A: begin
				if (s)
					next_state = B;
			end
			B: begin
				next_state = C;
			end
			C: begin
				next_state = D;
			end
			D: begin
				if (w_count == 2)
					z = 1;
				next_state = B;
			end
		endcase
	end

endmodule
