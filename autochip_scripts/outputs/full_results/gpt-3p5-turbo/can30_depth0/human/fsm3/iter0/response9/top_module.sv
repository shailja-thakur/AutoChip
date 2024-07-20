module top_module (
	input clk,
	input in,
	input areset,
	output out
);

	// Define the state machine states as parameters
	parameter A = 2'b00;
	parameter B = 2'b01;
	parameter C = 2'b10;
	parameter D = 2'b11;

	// Define the state register and the next state signal
	reg [1:0] state_reg;
	reg [1:0] next_state;

	// Define the output register
	reg out_reg;

	// Assign the output to the output register
	assign out = out_reg;

	// Define the positive edge triggered flip-flop for the state register
	always @(posedge clk or posedge areset) begin
		if (areset)
			state_reg <= A;
		else
			state_reg <= next_state;
	end

	// Define the combinational logic for determining the next state and output
	always @(state_reg, in) begin
		case (state_reg)
			A: begin
				if (in)
					next_state = B;
				else
					next_state = A;
				out_reg = 1'b0;
			end
			B: begin
				if (in)
					next_state = B;
				else
					next_state = C;
				out_reg = 1'b0;
			end
			C: begin
				if (in)
					next_state = D;
				else
					next_state = A;
				out_reg = 1'b0;
			end
			D: begin
				if (in)
					next_state = B;
				else
					next_state = C;
				out_reg = 1'b1;
			end
		endcase
	end
endmodule
