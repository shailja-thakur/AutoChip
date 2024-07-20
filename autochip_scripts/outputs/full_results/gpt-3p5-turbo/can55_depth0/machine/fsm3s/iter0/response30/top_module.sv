module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	// Define state values
	parameter A = 0;
	parameter B = 1;
	parameter C = 2;
	parameter D = 3;
	
	reg [1:0] state; // 2-bit register to store the state
	
	// Synchronous process for state transition
	always @(posedge clk or posedge reset)
	begin
		if (reset)
			state <= A;
		else
			case (state)
				A: begin
					if (in)
						state <= B;
					else
						state <= A;
				end
				B: begin
					if (in)
						state <= B;
					else
						state <= C;
				end
				C: begin
					if (in)
						state <= D;
					else
						state <= A;
				end
				D: begin
					if (in)
						state <= B;
					else
						state <= C;
				end
			endcase
	end
	
	// Output assignment
	assign out = (state == D) ? 1'b1 : 1'b0;
	
endmodule
