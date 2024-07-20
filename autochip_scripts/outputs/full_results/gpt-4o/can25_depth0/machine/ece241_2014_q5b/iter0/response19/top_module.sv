module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);
	// Define states
	parameter A = 1'b0;
	parameter B = 1'b1;

	// State register
	reg state;

	// State transition and output logic
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= A;
		end else begin
			case (state)
				A: state <= (x) ? B : A;
				B: state <= B;
				default: state <= A;
			endcase
		end
	end

	// Output logic
	always @(state or x) begin
		case (state)
			A: z = x ? 1'b1 : 1'b0;
			B: z = x ? 1'b0 : 1'b1;
			default: z = 1'b0;
		endcase
	end
endmodule
