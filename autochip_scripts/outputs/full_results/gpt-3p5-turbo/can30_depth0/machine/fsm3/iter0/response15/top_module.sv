module top_module (
	input clk,
	input in,
	input areset,
	output out
);

	// State definition
	typedef enum logic [1:0] {
		A, B, C, D
	} state_type;

	// State register
	reg [1:0] state;

	// Next state logic
	always_comb begin
		case(state)
			A: if (in) state = B; else state = A;
			B: if (in) state = B; else state = C;
			C: if (in) state = D; else state = A;
			D: if (in) state = B; else state = C;
		endcase
	end

	// Output logic
	assign out = (state == D);

	// State and reset control
	always_ff @(posedge clk or posedge areset) begin
		if (areset) state <= A;
		else state <= state;
	end

endmodule
