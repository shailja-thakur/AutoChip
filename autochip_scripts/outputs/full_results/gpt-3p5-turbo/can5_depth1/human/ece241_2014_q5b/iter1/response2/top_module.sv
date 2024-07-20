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

	always @(posedge clk or posedge areset) begin
		if (areset)
			current_state <= A;
		else
			current_state <= next_state;
	end

	always @* begin
		case (current_state)
			A: begin
				if (x)
					next_state = B;
				else
					next_state = A;
				z = 0;
			end
			B: begin
				if (x)
					next_state = B;
				else
					next_state = B;
				z = 1;
			end
			default: begin
				next_state = A;
				z = 0;
			end
		endcase
	end

endmodule
