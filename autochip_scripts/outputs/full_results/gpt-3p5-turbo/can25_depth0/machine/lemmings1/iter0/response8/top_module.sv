module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	output walk_left,
	output walk_right
);
	
	// Parameters
	parameter WL = 1;
	parameter WR = 0;
	
	// Registers
	reg state;
	
	// Combinational Logic
	always @ (posedge clk or posedge areset) begin
		if (areset) begin
			state <= WL;
		end else begin
			if (state == WL) begin
				if (bump_left) begin
					state <= WR;
				end else begin
					state <= WL;
				end
			end else if (state == WR) begin
				if (bump_right) begin
					state <= WL;
				end else begin
					state <= WR;
				end
			end
		end
	end
	
	// Output Assignment
	assign walk_left = (state == WL) ? 1'b1 : 1'b0;
	assign walk_right = (state == WR) ? 1'b1 : 1'b0;
	
endmodule
