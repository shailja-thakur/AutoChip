module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	// Define states
	typedef enum logic [1:0] {B, A} state_type;
	state_type state, next_state;
	
	// Define output
	logic out_reg;
	
	// Sequential logic
	always_ff @(posedge clk, posedge reset)
	begin
		if (reset)
			state <= B;
		else
			state <= next_state;
	end
	
	// Combinational logic
	always_comb
	begin
		case (state)
			B: begin
				if (in)
					next_state = B;
				else
					next_state = A;
				out_reg = 1;
			end
			A: begin
				if (in)
					next_state = A;
				else
					next_state = B;
				out_reg = 0;
			end
		endcase
	end
	
	// Assign outputs
	assign out = out_reg;
	
endmodule
