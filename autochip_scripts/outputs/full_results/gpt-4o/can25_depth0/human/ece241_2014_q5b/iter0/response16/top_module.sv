module top_module(
	input clk,
	input areset,
	input x,
	output z
);

	// State encoding using one-hot encoding
	reg [1:0] state, next_state;
	parameter A = 2'b01, B = 2'b10;

	// State register
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= A; // Reset to state A
		end else begin
			state <= next_state;
		end
	end

	// Next state logic
	always @(*) begin
		case (state)
			A: begin
				if (x) 
					next_state = B;
				else 
					next_state = A;
			end
			B: begin
				if (x)
					next_state = B;
				else
					next_state = B;
			end
			default: next_state = A; // Default to safe state A
		endcase
	end

	// Output logic
	assign z = (state == A) ? x : ~x;

endmodule
