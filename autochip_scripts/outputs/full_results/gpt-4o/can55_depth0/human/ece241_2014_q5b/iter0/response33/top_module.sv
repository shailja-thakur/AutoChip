module top_module (
	input clk,
	input areset,
	input x,
	output z
);

	// State encoding using one-hot encoding
	typedef enum reg [1:0] {
		A = 2'b01,
		B = 2'b10
	} state_t;

	state_t state, next_state;

	// Combinational logic for next state and output
	always @(*) begin
		next_state = state;  // Default to hold state
		case (state)
			A: begin
				if (x == 1'b0) begin
					next_state = A;
					z = 1'b0;
				end else begin
					next_state = B;
					z = 1'b1;
				end
			end
			B: begin
				if (x == 1'b0) begin
					next_state = B;
					z = 1'b1;
				end else begin
					next_state = B;
					z = 1'b0;
				end
			end
		endcase
	end

	// Sequential logic for state transitions
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= A;
		end else begin
			state <= next_state;
		end
	end

endmodule
