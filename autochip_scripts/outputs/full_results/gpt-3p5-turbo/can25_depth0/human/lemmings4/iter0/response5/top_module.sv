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

reg [4:0] state;
// states
parameter idle = 4'b0000;
parameter left = 4'b0001;
parameter right = 4'b0010;
parameter fall = 4'b0011;
parameter dig = 4'b0100;
parameter splatter = 4'b0101;

reg [4:0] next_state;
reg walk_left;
reg walk_right;
reg aaah;
reg digging;

always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= idle;
	end else begin
		state <= next_state;
	end
end

always @* begin
	case(state)
		idle: begin
			walk_left = 1;
			walk_right = 0;
			aaah = 0;
			digging = 0;
			if (bump_left) begin
				next_state = right;
			end else if (bump_right) begin
				next_state = left;
			end else if (!ground) begin
				next_state = fall;
			end else begin
				next_state = idle;
			end
		end
		
		left: begin
			walk_left = 1;
			walk_right = 0;
			aaah = 0;
			digging = 0;
			if (bump_left) begin
				next_state = right;
			end else if (bump_right) begin
				next_state = left;
			end else if (!ground) begin
				next_state = fall;
			end else begin
				next_state = left;
			end
		end
		
		right: begin
			walk_left = 0;
			walk_right = 1;
			aaah = 0;
			digging = 0;
			if (bump_left) begin
				next_state = right;
			end else if (bump_right) begin
				next_state = left;
			end else if (!ground) begin
				next_state = fall;
			end else begin
				next_state = right;
			end
		end
		
		fall: begin
			walk_left = 0;
			walk_right = 0;
			aaah = 1;
			digging = 0;
			if (ground) begin
				next_state = fall;
			end else if (bump_left || bump_right) begin
				next_state = fall;
			end else begin
				next_state = idle;
			end
		end
		
		dig: begin
			walk_left = 0;
			walk_right = 0;
			aaah = 0;
			digging = 1;
			if (!ground || state == splatter) begin
				next_state = dig;
			end else if (!dig && ground) begin
				next_state = idle;
			end else begin
				next_state = dig;
			end
		end
		
		splatter: begin
			walk_left = 0;
			walk_right = 0;
			aaah = 0;
			digging = 0;
			if (ground) begin
				next_state = splatter;
			end else begin
				next_state = idle;
			end
		end
	endcase
end

endmodule
