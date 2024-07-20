module top_module (
	input clk,
	input in,
	input areset,
	output out
);

	// Define the states
	enum logic [1:0] states;
	parameter A = 2'b00;
	parameter B = 2'b01;
	parameter C = 2'b10;
	parameter D = 2'b11;

	// Define the outputs
	logic output;

	// Define the registers
	reg nextState;
	reg currentOutput;

	always_comb
		case (states)
			A: begin
				nextState = in ? B : A;
				currentOutput = 1'b0;
			end
			B: begin
				nextState = in ? B : C;
				currentOutput = 1'b0;
			end
			C: begin
				nextState = in ? D : A;
				currentOutput = 1'b0;
			end
			D: begin
				nextState = in ? B : C;
				currentOutput = 1'b1;
			end
		endcase
	
	always_ff @(posedge clk or posedge areset)
		if (areset)
			states <= A;
		else
			states <= nextState;

	always_ff @(posedge clk)
		out <= currentOutput;

endmodule
