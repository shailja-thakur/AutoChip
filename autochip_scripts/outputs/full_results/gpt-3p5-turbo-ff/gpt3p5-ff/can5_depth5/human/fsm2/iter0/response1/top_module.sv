module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output reg out
);

	// state enumeration
	parameter OFF = 1'b0;
	parameter ON = 1'b1;
	
	// state register
	reg [1:0] state;
	
	always @(posedge clk or posedge areset)
	begin
		if (areset)
			state <= OFF;
		else
		begin
			case (state)
				ON: if (k) state <= OFF;
				OFF: if (j) state <= ON;
			endcase
		end
	end
	
	// output logic
	always @(state)
	begin
		case (state)
			ON: out = 1'b1;
			OFF: out = 1'b0;
		endcase
	end
endmodule
