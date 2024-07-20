module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);
	// parameter and wire declaration
	parameter OFF = 1'b0;
	parameter ON = 1'b1;
	reg state;
	
	// assign initial state based on reset input
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= OFF;
		end else begin
			case(state)
				OFF: begin
					if (j) begin
						state <= ON;
					end
				end
				
				ON: begin
					if (k) begin
						state <= OFF;
					end
				end
			endcase
		end
	end
	
	// assign output based on current state
	assign out = (state == ON) ? 1'b1 : 1'b0;
endmodule
