module top_module (
	input clk,
	input in,
	input areset,
	output out
);

	// Define the states
	typedef enum logic [1:0] {
		A,
		B
	} state_t;

	// Declare state and next_state variables
	state_t state;
	state_t next_state;

	always_ff @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= B;
		end else begin
			state <= next_state;
		end
	end

	always_comb begin
		case (state)
			A: begin
				if (in) begin
					next_state = A;
				end else begin
					next_state = B;
				end
			end
			B: begin
				if (in) begin
					next_state = B;
				end else begin
					next_state = A;
				end
			end
		endcase
	end

	assign out = (state == B) ? 1'b1 : 1'b0;

endmodule
