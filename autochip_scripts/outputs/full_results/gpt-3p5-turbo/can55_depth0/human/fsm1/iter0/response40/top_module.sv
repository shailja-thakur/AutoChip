module top_module (
	input clk,
	input in,
	input areset,
	output out
);
	// Define the state encoding
	typedef enum logic [1:0] {
		A,
		B
	} state_t;

	// Define the state register and initialize it to B
	reg state_t current_state = B;

	// Define the next state logic
	always_ff @(posedge clk, negedge areset) begin
		if (areset)
			current_state <= B;
		else begin
			case (current_state)
				A: current_state <= (in) ? A : B;
				B: current_state <= (in) ? B : A;
				default: current_state <= B;
			endcase
		end
	end

	// Define the output logic
	always_comb begin
		case (current_state)
			A: out = 1'b0;
			B: out = 1'b1;
			default: out = 1'b0;
		endcase
	end
endmodule
