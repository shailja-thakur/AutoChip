module top_module (
	input clk,
	input in,
	input areset,
	output out
);

	// State definition
	typedef enum logic [1:0] {
		B,
		A
	} state_t;

	// Register to hold current state
	reg state_t curr_state;

	// Output register
	reg out_reg;

	// State transition logic
	always_ff @(posedge clk or posedge areset) begin
		if (areset) begin
			curr_state <= B;
		end else begin
			case (curr_state)
				B: begin
					if (in)
						curr_state <= B;
					else
						curr_state <= A;
				end
				A: begin
					if (in)
						curr_state <= A;
					else
						curr_state <= B;
				end
			endcase
		end
	end

	// Output logic
	always_comb begin
		case (curr_state)
			B: out_reg = 1'b1;
			A: out_reg = 1'b0;
		endcase
	end

	assign out = out_reg;

endmodule
