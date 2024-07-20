module top_module (
	input clk,
	input areset,
	input x,
	output z
);

	// Parameter definitions
	parameter A = 2'b00;
	parameter B = 2'b01;
	parameter C = 2'b10;

	// State register definition
	reg [1:0] state;

	// Always block triggered on the positive edge of the clock and the reset signal
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= A;
		end else begin
			case (state)
				A: state <= (x) ? C : A;
				B: state <= (x) ? B : C;
				C: state <= (x) ? B : C;
			endcase
		end
	end

	// Output assignment based on the state of the machine
	assign z = (state == C) ? 1'b1 : 1'b0;

endmodule
