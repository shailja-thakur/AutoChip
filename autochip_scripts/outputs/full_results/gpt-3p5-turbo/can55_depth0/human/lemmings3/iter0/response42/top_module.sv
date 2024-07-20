module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	input ground,
	input dig,
	output walk_left,
	output walk_right,
	output aaah,
	output digging
);

reg [1:0] state;
reg walk_left;
reg walk_right;
reg aaah;
reg digging;

always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= 2'b11;
		walk_left <= 1'b1;
		walk_right <= 1'b0;
		aaah <= 1'b0;
		digging <= 1'b0;
	end else begin
		case(state)
			2'b00:
				if(ground) begin
					state <= 2'b01;
					walk_left <= 1'b0;
					walk_right <= 1'b1;
					aaah <= 1'b0;
					digging <= 1'b0;
				end
			2'b01:
				if(ground && !bump_right) begin
					state <= 2'b10;
					walk_left <= 1'b0;
					walk_right <= 1'b1;
					aaah <= 1'b0;
					digging <= 1'b1;
				end else if(!ground && !bump_right) begin
					state <= 2'b00;
					walk_left <= 1'b0;
					walk_right <= 1'b0;
					aaah <= 1'b1;
					digging <= 1'b0;
				end else if(ground && bump_right) begin
					state <= 2'b00;
					walk_left <= 1'b1;
					walk_right <= 1'b0;
					aaah <= 1'b0;
					digging <= 1'b0;
				end
			2'b10:
				if(!ground) begin
					state <= 2'b00;
					walk_left <= 1'b0;
					walk_right <= 1'b0;
					aaah <= 1'b1;
					digging <= 1'b0;
				end
			2'b11:
				if(!areset) begin
					state <= 2'b00;
					walk_left <= 1'b1;
					walk_right <= 1'b0;
					aaah <= 1'b0;
					digging <= 1'b0;
				end
		endcase
	end
end

endmodule
