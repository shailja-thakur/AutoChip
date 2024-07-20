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
    STATE_WALK_LEFT = 3'b000,
    STATE_WALK_RIGHT = 3'b001,
    STATE_FALL = 3'b010,
    STATE_DIG_LEFT = 3'b011,
    STATE_DIG_RIGHT = 3'b100;

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
        if (state == STATE_FALL) begin
            fall_count <= fall_count + 1;
        end
        else begin
            fall_count <= 0;
        end
    end
end

always @(*) begin
    next_state = state;
    walk_left = 0;
    walk_right = 0;
    aaah = 0;
    digging = 0;

    case (state)
        STATE_WALK_LEFT: begin
            walk_left = 1;
            if (bump_right) begin
                next_state = STATE_WALK_RIGHT;
            end
            else if (~ground) begin
                next_state = STATE_FALL;
            end
            else if (dig) begin
                next_state = STATE_DIG_LEFT;
            end
        end
        STATE_WALK_RIGHT: begin
            walk_right = 1;
            if (bump_left) begin
                next_state = STATE_WALK_LEFT;
            end
            else if (~ground) begin
                next_state = STATE_FALL;
            end
            else if (dig) begin
                next_state = STATE_DIG_RIGHT;
            end
        end
        STATE_FALL: begin
            aaah = 1;
            if (ground) begin
                if (fall_count >= 20) begin
                    // Splatter
                    walk_left = 0;
                    walk_right = 0;
                    aaah = 0;
                    digging = 0;
                    next_state = STATE_WALK_LEFT; // Reset to walk left
                end
                else begin
                    if (walk_left) begin
                        next_state = STATE_WALK_LEFT;
                    end
                    else begin
                        next_state = STATE_WALK_RIGHT;
                    end
                end
            end
        end
        STATE_DIG_LEFT: begin
            digging = 1;
            walk_left = 1;
            if (~ground) begin
                next_state = STATE_FALL;
            end
            else if (~dig) begin
                next_state = STATE_WALK_LEFT;
            end
        end
        STATE_DIG_RIGHT: begin
            digging = 1;
            walk_right = 1;
            if (~ground) begin
                next_state = STATE_FALL;
            end
            else if (~dig) begin
                next_state = STATE_WALK_RIGHT;
            end
        end
    endcase
end

endmodule
