module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

	// Define states using a parameter
	parameter A = 0, B = 1, C = 2, D = 3;
	reg [1:0] state;
	
	// Assign initial state
	always @(posedge reset)
	begin
		if (reset)
			state <= A;
	end

	// State transition and output logic
	always @(posedge clk)
	begin
		case (state)
			A: 
			begin
				if (in)
					state <= B;
				else
					state <= A;
			end

			B: 
			begin
				if (in)
					state <= B;
				else
					state <= C;
			end

			C: 
			begin
				if (in)
					state <= D;
				else
					state <= A;
			end

			D: 
			begin
				if (in)
					state <= B;
				else
					state <= C;
			end
		endcase
	end

	// Assign output
	always @(state)
	begin
		if (state == D)
			out <= 1'b1;
		else
			out <= 1'b0;
	end
	
endmodule
