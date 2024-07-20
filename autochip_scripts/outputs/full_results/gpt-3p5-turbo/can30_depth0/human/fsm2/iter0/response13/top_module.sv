module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);

	// Internal state variable
	reg [1:0] state;
	
	// Output variable
	reg out;
	
	// Synchronous reset
	always @(posedge clk or posedge areset)
	begin
		if (areset)
			state <= 2'b0;
		else
		begin
			case (state)
				2'b0: if (j) state <= 2'b1;
				2'b1: if (k) state <= 2'b0;
			endcase
		end
	end
	
	// Output assignment
	always @(state) 
	begin
		case (state)
			2'b0: out = 1'b0;
			2'b1: out = 1'b1;
		endcase
	end
	
endmodule
