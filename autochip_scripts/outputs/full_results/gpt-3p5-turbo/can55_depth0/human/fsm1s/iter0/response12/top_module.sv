module top_module (
	input clk,
	input in,
	input reset,
	output out
);
	
	// Define the states
	parameter B = 0;
	parameter A = 1;
	
	reg [1:0] state; // 2-bit register to store the current state
	
	// Output assignment
	always @(state)
	begin
		case (state)
			B: out = 1;
			A: out = 0;
		endcase
	end
	
	// State transition logic
	always @(posedge clk or posedge reset)
	begin
		if (reset)
			state <= B; // Reset state
		else
		begin
			case (state)
				B: state <= in ? B : A;
				A: state <= in ? A : B;
			endcase
		end
	end
	
endmodule
