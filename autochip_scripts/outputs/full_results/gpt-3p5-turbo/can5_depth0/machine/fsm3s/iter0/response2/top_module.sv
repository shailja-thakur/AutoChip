module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	// Declare the states as parameters
	parameter A = 2'b00;
	parameter B = 2'b01;
	parameter C = 2'b10;
	parameter D = 2'b11;

	reg [1:0] state;   // Declare a 2-bit state register

	// Flip-flop for the state
	always @(posedge clk or posedge reset)
	begin
		if (reset)
			state <= A;   // Reset the state to A
		else
		begin
			case (state)
				A: if (in) state <= B; else state <= A;
				B: if (in) state <= B; else state <= C;
				C: if (in) state <= D; else state <= A;
				D: if (in) state <= B; else state <= C;
			endcase
		end
	end

	// Logic for the output
	assign out = (state == D) ? 1'b1 : 1'b0;

endmodule
