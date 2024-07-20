module top_module (
	input clk,
	input in,
	input reset,
	output out
);
		// Declare state register
		reg [1:0] state;
		
		// Declare output register
		reg out_reg;
		
		// Define states
		parameter B = 2'b00;
		parameter A = 2'b01;
		
		// Define next state logic
		always @(posedge clk or posedge reset)
		begin
			if (reset)
				state <= B;
			else
			begin
				case (state)
					B: if (in) state <= B; else state <= A;
					A: if (in) state <= A; else state <= B;
				endcase
			end
		end
		
		// Define output logic
		always @(state, in)
		begin
			case (state)
				B: out_reg = 1'b1;
				A: out_reg = 1'b0;
			endcase
		end
		
		// Assign output
		assign out = out_reg;
endmodule
