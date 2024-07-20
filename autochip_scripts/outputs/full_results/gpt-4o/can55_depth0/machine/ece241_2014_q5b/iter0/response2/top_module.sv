module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

	// Definition of the states
	parameter A = 1'b0, B = 1'b1;

	// State register
	reg state;

	// Next state logic
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= A;
		else begin
			case (state)
				A: if (x) state <= B;
				   else state <= A;
				B: state <= B;
				default: state <= A;
			endcase
		end
	end

	// Output logic
	always @(state, x) begin
		case (state)
			A: z = x ? 1'b1 : 1'b0;
			B: z = x ? 1'b0 : 1'b1;
			default: z = 1'b0;
		endcase
	end
endmodule
