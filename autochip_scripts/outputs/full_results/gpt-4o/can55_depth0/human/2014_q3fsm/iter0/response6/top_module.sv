module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

	// State encoding
	typedef enum reg [1:0] {
		A = 2'b00,
		B = 2'b01,
		C = 2'b10,
		D = 2'b11
	} state_t;
	
	state_t state, next_state;
	reg [1:0] w_count; // Counter for number of `1`s in state B

	// Sequential logic to update the state
	always @(posedge clk) begin
		if (reset)
			state <= A;
		else
			state <= next_state;
	end

	// Combinational logic for next state
	always @(*) begin
		case (state)
			A: if (s) next_state = B; else next_state = A;
			B: if (w_count == 2) next_state = C; else next_state = D;
			C: next_state = B;
			D: next_state = B;
			default: next_state = A;
		endcase
	end

	// Counter logic to count the number of 1's in state B
	always @(posedge clk) begin
		if (reset)
			w_count <= 0;
		else if (state == B) begin
			if (next_state != B)
				w_count <= 0;
			else if (w)
				w_count <= w_count + 1;
			else
				w_count <= w_count;
		end
	end

	// Output logic
	always @(posedge clk) begin
		if (reset)
			z <= 0;
		else if (state == C)
			z <= 1;
		else
			z <= 0;
	end

endmodule
