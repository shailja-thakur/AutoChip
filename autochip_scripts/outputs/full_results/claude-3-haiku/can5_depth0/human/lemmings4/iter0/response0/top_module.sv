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

localparam [2:0] 
    STATE_WALK_LEFT = 3'd0,
    STATE_WALK_RIGHT = 3'd1,
    STATE_FALLING = 3'd2, 
    STATE_DIGGING = 3'd3,
    STATE_SPLATTERED = 3'd4;

reg [2:0] current_state, next_state;
reg [4:0] fall_counter;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        current_state <= STATE_WALK_LEFT;
        fall_counter <= 0;
    end
    else begin
        current_state <= next_state;
        if (current_state == STATE_FALLING)
            fall_counter <= fall_counter + 1;
        else
            fall_counter <= 0;
    end
end

always @(*) begin
    next_state = current_state;
    walk_left = 0;
    walk_right = 0;
    aaah = 0;
    digging = 0;

    case (current_state)
        STATE_WALK_LEFT: begin
            walk_left = 1;
            if (bump_right)
                next_state = STATE_WALK_RIGHT;
            else if (!ground)
                next_state = STATE_FALLING;
            else if (dig && ground)
                next_state = STATE_DIGGING;
        end
        STATE_WALK_RIGHT: begin
            walk_right = 1;
            if (bump_left)
                next_state = STATE_WALK_LEFT;
            else if (!ground)
                next_state = STATE_FALLING;
            else if (dig && ground)
                next_state = STATE_DIGGING;
        end
        STATE_FALLING: begin
            aaah = 1;
            if (ground)
                if (walk_left)
                    next_state = STATE_WALK_LEFT;
                else
                    next_state = STATE_WALK_RIGHT;
            else if (fall_counter >= 20)
                next_state = STATE_SPLATTERED;
        end
        STATE_DIGGING: begin
            digging = 1;
            if (!ground)
                next_state = STATE_FALLING;
            else if (!dig)
                if (walk_left)
                    next_state = STATE_WALK_LEFT;
                else
                    next_state = STATE_WALK_RIGHT;
        end
        STATE_SPLATTERED: begin
            // do nothing
        end
    endcase
end

endmodule
