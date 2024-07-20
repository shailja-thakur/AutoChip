module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

	// Define states
	parameter A = 1'b0;
	parameter B = 1'b1;

	reg state;

	// State machine always block
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= A;
		else begin
			case (state)
				A: begin
					if (x)
						state <= B;
					else
						state <= A;
				end
				B: begin
					state <= B;
				end
			endcase
		end
	end

	// Output logic
	always @(state, x) begin
		case (state)
			A: begin
				if (x)
					z <= 1'b1;
				else
					z <= 1'b0;
			end
			B: begin
				if (~x)
					z <= 1'b1;
				else
					z <= 1'b0;
			end
		endcase
	end

endmodule
