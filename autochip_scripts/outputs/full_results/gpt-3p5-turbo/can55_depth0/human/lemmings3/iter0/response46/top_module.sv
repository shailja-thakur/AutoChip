module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	input ground,
	input dig,
	output reg walk_left,
	output reg walk_right,
	output reg aaah,
	output reg digging
);

// states
parameter WALK_LEFT = 2'b00;
parameter WALK_RIGHT = 2'b01;
parameter FALL = 2'b10;
parameter DIG = 2'b11;

reg [1:0] state, next_state;

// register assignments
reg [2:0] direction;

// state transition and output logic
always @(posedge clk or posedge areset) begin
	if (areset) begin
		// reset the lemming machine to walk left
		state <= WALK_LEFT;
		direction <= 3'b000;
		aaah <= 0;
		digging <= 0;
	end else begin
		state <= next_state;
		direction <= {direction[1:0], 1'b0};

		case (state)
			WALK_LEFT: begin
				aaah <= 1'b0;
				digging <= 1'b0;
				if (bump_right) begin
					next_state <= WALK_RIGHT;
				end else if (dig && ground) begin
					next_state <= DIG;
				end else if (!ground) begin
					next_state <= FALL;
				end else begin
					next_state <= WALK_LEFT;
				end
			end

			WALK_RIGHT: begin
				aaah <= 1'b0;
				digging <= 1'b0;
				if (bump_left) begin
					next_state <= WALK_LEFT;
				end else if(dig && ground) begin
					next_state <= DIG;
				end else if (!ground) begin
					next_state <= FALL;
				end else begin
					next_state <= WALK_RIGHT;
				end
			end

			FALL: begin
				aaah <= 1'b1;
				digging <= 1'b0;
				if (ground) begin
					if (direction[1]) begin
						next_state <= WALK_RIGHT;
					end else begin
						next_state <= WALK_LEFT;
					end
				end else begin
					next_state <= FALL;
				end
			end

			DIG: begin
				aaah <= 1'b0;
				digging <= 1'b1;
				if (!ground) begin
					next_state <= FALL;
				end else begin
					next_state <= DIG;
				end
			end
		endcase
	end
end

// output assignments
always @(posedge clk) begin
	case (state)
		WALK_LEFT: begin
			walk_left <= 1;
			walk_right <= 0;
		end

		WALK_RIGHT: begin
			walk_left <= 0;
			walk_right <= 1;
		end

		FALL: begin
			walk_left <= 0;
			walk_right <= 1;
		end

		DIG: begin
			walk_left <= 0;
			walk_right <= 1;
		end
	endcase
end

endmodule
