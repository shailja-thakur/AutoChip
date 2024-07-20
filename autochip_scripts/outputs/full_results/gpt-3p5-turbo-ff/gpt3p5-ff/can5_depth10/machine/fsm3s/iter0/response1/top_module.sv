module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	// Define the states using enum
	typedef enum logic [1:0] {
		A,
		B,
		C,
		D
	} state;

	// Declare the state variable
	reg state current_state, next_state;

	// Define the combinational logic for next_state
	always_comb begin
		case (current_state)
			A: begin
				if (in == 1)
					next_state = B;
				else
					next_state = A;
			end
			B: begin
				if (in == 1)
					next_state = B;
				else
					next_state = C;
			end
			C: begin
				if (in == 1)
					next_state = D;
				else
					next_state = A;
			end
			D: begin
				if (in == 1)
					next_state = B;
				else
					next_state = C;
			end
		endcase
	end

	// Define the sequential logic for current_state
	always_ff @(posedge clk, posedge reset) begin
		if (reset == 1)
			current_state <= A;
		else
			current_state <= next_state;
	end

	// Define the output
	assign out = (current_state == D);

endmodule
