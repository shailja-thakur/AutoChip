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

localparam [2:0] STATE_WALK_LEFT = 3'b000,
                 STATE_WALK_RIGHT = 3'b001,
                 STATE_FALL = 3'b010,
                 STATE_DIG = 3'b011,
                 STATE_SPLATTER = 3'b111;

reg [2:0] state, next_state;
reg [4:0] fall_count;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= STATE_WALK_LEFT;
        fall_count <= 0;
        walk_left <= 1;
        walk_right <= 0;
        aaah <= 0;
        digging <= 0;
    end
    else begin
        state <= next_state;
        fall_count <= (state == STATE_FALL) ? fall_count + 1 : 0;
        walk_left <= (state == STATE_WALK_LEFT);
        walk_right <= (state == STATE_WALK_RIGHT);
        aaah <= (state == STATE_FALL);
        digging <= (state == STATE_DIG);
    end
end

always @(*) begin
    case (state)
        STATE_WALK_LEFT: begin
            if (bump_right) next_state = STATE_WALK_RIGHT;
            else if (!ground) next_state = STATE_FALL;
            else if (dig && ground) next_state = STATE_DIG;
            else next_state = STATE_WALK_LEFT;
        end
        STATE_WALK_RIGHT: begin
            if (bump_left) next_state = STATE_WALK_LEFT;
            else if (!ground) next_state = STATE_FALL;
            else if (dig && ground) next_state = STATE_DIG;
            else next_state = STATE_WALK_RIGHT;
        end
        STATE_FALL: begin
            if (ground) next_state = STATE_WALK_LEFT; // or STATE_WALK_RIGHT, depending on previous direction
            else if (fall_count == 20) next_state = STATE_SPLATTER;
            else next_state = STATE_FALL;
        end
        STATE_DIG: begin
            if (!ground) next_state = STATE_FALL;
            else next_state = STATE_DIG;
        end
        STATE_SPLATTER: begin
            next_state = STATE_SPLATTER;
        end
        default: next_state = STATE_WALK_LEFT;
    endcase
end

endmodule
