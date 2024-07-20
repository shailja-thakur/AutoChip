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

/* State declarations */
reg [2:0] state;
parameter [2:0] WALK_LEFT = 3'b000;
parameter [2:0] WALK_RIGHT = 3'b001;
parameter [2:0] FALL = 3'b010;
parameter [2:0] DIG = 3'b011;
parameter [2:0] SPLATTER = 3'b100;

/* Output assignments */
assign walk_left = (state == WALK_LEFT) ? 1 : 0;
assign walk_right = (state == WALK_RIGHT) ? 1 : 0;
assign aaah = (state == FALL || state == SPLATTER) ? 1 : 0;
assign digging = (state == DIG) ? 1 : 0;

/* State machine */
always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;
    end
    else begin
        case (state)
            WALK_LEFT:
                if (bump_left && !bump_right)
                    state <= WALK_RIGHT;
                else if (!bump_left && bump_right)
                    state <= WALK_LEFT;
                else if (bump_left && bump_right)
                    state <= WALK_RIGHT;
                else if (dig && ground)
                    state <= DIG;
                else if (!ground)
                    state <= FALL;
                else
                    state <= WALK_LEFT;
            
            WALK_RIGHT:
                if (!bump_left && bump_right)
                    state <= WALK_LEFT;
                else if (bump_left && !bump_right)
                    state <= WALK_RIGHT;
                else if (bump_left && bump_right)
                    state <= WALK_LEFT;
                else if (dig && ground)
                    state <= DIG;
                else if (!ground)
                    state <= FALL;
                else
                    state <= WALK_RIGHT;
            
            FALL:
                if (ground)
                    state <= WALK_LEFT;
                else
                    state <= FALL;

            DIG:
                if (!ground)
                    state <= FALL;
                else if (!dig)
                    state <= WALK_LEFT;
                else
                    state <= DIG;
            
            SPLATTER:
                state <= SPLATTER;
        endcase
    end
end

endmodule
