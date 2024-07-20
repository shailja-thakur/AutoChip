module top_module (
	input clk,
	input areset,
	input x,
	output z
);
	// State definitions
	parameter A = 1'b1;
	parameter B = 1'b0;
	
	// State register
	reg state;
	
	// Output register
	reg out;
	
	// Next state and output logic
	always @ (posedge clk or posedge areset)
	begin
		if (areset)
			state <= A;
		else
		begin
			case (state)
				A: if (x) state <= B;
				   else state <= A;
				B: if (x) state <= B;
				   else state <= B;
			endcase
		end
		
		case (state)
			A: out <= 1'b0;
			B: out <= 1'b1;
		endcase
	end
	
	// Assign output
	assign z = out;
endmodule
