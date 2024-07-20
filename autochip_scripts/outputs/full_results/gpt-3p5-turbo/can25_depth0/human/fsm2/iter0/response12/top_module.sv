module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);
	parameter OFF = 1'b0;
	parameter ON = 1'b1;
	
	reg [1:0] state;
	
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= OFF;
		else begin
			case (state)
				ON: begin
					if (k)
						state <= OFF;
				end
				OFF: begin
					if (j)
						state <= ON;
				end
			endcase
		end
	end
	
	always @(state) begin
		case (state)
			ON: out = 1'b1;
			OFF: out = 1'b0;
		endcase
	end
endmodule
