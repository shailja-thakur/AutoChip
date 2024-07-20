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

	reg state current_state, next_state;

	// Assign initial state
	initial begin
		current_state = B;
	end

	// State transition logic
	always @(posedge clk, posedge areset) begin
		if (areset) begin
			current_state <= B;
		end else begin
			current_state <= next_state;
		end
	end

	// Next state logic
	always @(current_state, in) begin
		case (current_state)
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

	// Output logic
	assign out = (current_state == B) ? 1'b1 : 1'b0;

endmodule
