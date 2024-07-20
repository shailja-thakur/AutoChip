module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	input ground,
	output walk_left,
	output walk_right,
	output aaah
);

reg walking_left;
reg walking_right;
reg falling;
reg aaah_state;

always @(posedge clk or posedge areset) begin
	if(areset) begin
		walking_left <= 1;
		walking_right <= 0;
		falling <= 0;
		aaah_state <= 0;
	end else begin
		if(falling) begin
			walking_left <= walking_left;
			walking_right <= walking_right;
		end else if(bump_left) begin
			walking_left <= 0;
			walking_right <= 1;
		end else if(bump_right) begin
			walking_left <= 1;
			walking_right <= 0;
		end else if(bump_left && bump_right) begin
			walking_left <= 0;
			walking_right <= 1;
		end else if(ground == 0) begin
			walking_left <= walking_left;
			walking_right <= walking_right;
		end;
		
		if(ground == 1 && !falling) begin
			falling <= 0;
		end else if(ground == 0 && !falling) begin
			aaah_state <= 1;
		end;
	end
end

assign walk_left = walking_left;
assign walk_right = walking_right;
assign aaah = aaah_state;

endmodule
