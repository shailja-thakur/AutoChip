module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	output walk_left,
	output walk_right
);
	parameter WL = 0;
	parameter WR = 1;

	reg state;
	
	always @(posedge clk) begin
		if(areset == 1'b1) begin
			state <= WL;
		end else begin
			if(state == WL) begin
				if(bump_left == 1'b1) begin
					state <= WR;
				end else begin
					state <= WL;
				end
			end else if(state == WR) begin
				if(bump_right == 1'b1) begin
					state <= WL;
				end else begin
					state <= WR;
				end
			end
		end
	end
	
	always @(posedge clk) begin
		if(state == WL) begin
			walk_left <= 1'b1;
			walk_right <= 1'b0;
		end else if(state == WR) begin
			walk_left <= 1'b0;
			walk_right <= 1'b1;
		end
	end

endmodule
