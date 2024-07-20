module top_module (
    input clk,
    input in,
    input areset,
    output out
);

	// State enumeration
	typedef enum logic [1:0] {
		A,
		B
	} state;

	// Registers and wires declaration
	reg state current_state;
	wire next_state;

	// Next state logic
	always_comb begin
		case(current_state)
			A: if (in) next_state = A; else next_state = B;
			B: if (in) next_state = B; else next_state = A;
		endcase
	end

	// Sequential logic
	always_ff @(posedge clk or posedge areset) begin
		if (areset) begin
			current_state <= B;
		end else begin
			current_state <= next_state;
		end
	end

	// Output logic
	assign out = (current_state == A) ? 1'b0 : 1'b1;

endmodule
