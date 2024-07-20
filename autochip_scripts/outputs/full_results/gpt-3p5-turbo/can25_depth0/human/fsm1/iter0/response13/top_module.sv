module top_module (
	input clk,
	input in,
	input areset,
	output out
);

	// Define states
	parameter B = 1'b0;
	parameter A = 1'b1;

	// Define outputs
	reg out;

	// Define state register
	reg state;

	// Output logic
	always @ (posedge clk, posedge areset)
	begin
		// Reset logic
		if (areset)
			state <= B;

		// State transition logic
		else
			case (state)
				B: begin
					if (in)
						state <= A;
				end
				A: begin
					if (in)
						state <= A;
					else
						state <= B;
				end
			endcase
	end

	// Output assignment
	always @ (state)
	begin
		case (state)
			B: begin
				out <= 1'b0;
			end
			A: begin
				out <= 1'b1;
			end
		endcase
	end

endmodule
