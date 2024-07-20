module top_module (
      input clk,
      input areset,
      input x,
      output reg z
);
	// Define states
	typedef enum logic [1:0] {A, B} state_t;
	// State register
	reg state_t current_state, next_state;
	// Output register
	reg z_reg;

	always_ff @(posedge clk or posedge areset) begin
		if (areset)
			current_state <= A;
		else
			current_state <= next_state;
	end

	always_comb begin
		case (current_state)
			A: begin
				if (x)
					next_state = B;
				else
					next_state = A;
				z_reg = 0;
			end
			B: begin
				if (x)
					next_state = A;
				else
					next_state = B;
				z_reg = 1;
			end
			default: begin
				next_state = A;
				z_reg = 0;
			end
		endcase
	end

	always @(posedge clk) begin
		z <= z_reg;
	end
endmodule
