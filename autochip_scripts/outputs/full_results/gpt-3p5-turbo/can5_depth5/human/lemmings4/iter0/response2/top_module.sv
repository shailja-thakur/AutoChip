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

parameter [4:0] WALK_LEFT = 5'b00001;
parameter [4:0] WALK_RIGHT = 5'b00010;
parameter [4:0] FALL = 5'b00011;
parameter [4:0] DIG = 5'b00100;
parameter [4:0] SPLATTER = 5'b00101;

always @(posedge clk or posedge areset) begin
    if (areset)
        state <= WALK_LEFT;
    else begin
        case (state)
            WALK_LEFT:
                if (bump_right)
                    state <= WALK_RIGHT;
                else if (ground)
                    state <= WALK_LEFT;
                else if (dig)
                    state <= DIG;
                else
                    state <= FALL;
					
            WALK_RIGHT:
                if (bump_left)
                    state <= WALK_LEFT;
                else if (ground)
                    state <= WALK_RIGHT;
                else if (dig)
                    state <= DIG;
                else
                    state <= FALL;
					
            FALL:
                if (ground)
                    state <= WALK_LEFT;
                else if (dig)
                    state <= DIG;
                else if (state == SPLATTER && ground)
                    state <= WALK_LEFT;
                else if (state == SPLATTER && !ground)
                    state <= FALL;
                else if (state != SPLATTER && state != DIG && state != FALL)
                    state <= SPLATTER;
					
            DIG:
                if (bump_left && !ground)
                    state <= DIG;
                else if (bump_right && !ground)
                    state <= DIG;
                else if (!ground)
                    state <= FALL;
                else
                    state <= WALK_LEFT;
					
            SPLATTER:
                state <= SPLATTER;
        endcase
    end
end

assign walk_left = (state == WALK_LEFT || state == DIG || state == FALL);
assign walk_right = (state == WALK_RIGHT);
assign aaah = (state == FALL && !ground);
assign digging = (state == DIG);

endmodule
