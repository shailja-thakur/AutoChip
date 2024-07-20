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
    STATE_FALLING = 3'b010,
    STATE_DIGGING = 3'b011,
    STATE_SPLATTER = 3'b100;

reg [2:0] state, next_state;
reg [4:0] fall_counter;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= STATE_WALK_LEFT;
        walk_left <= 1;
        walk_right <= 0;
        aaah <= 0;
        digging <= 0;
        fall_counter <= 0;
    end
    else begin
        state <= next_state;
        walk_left <= (state == STATE_WALK_LEFT);
        walk_right <= (state == STATE_WALK_RIGHT);
        aaah <= (state == STATE_FALLING);
        digging <= (state == STATE_DIGGING);
        if (state == STATE_FALLING) begin
            fall_counter <= fall_counter + 1;
        end
        else begin
            fall_counter <= 0;
        end
    end
end

always @(*) begin
    case (state)
        STATE_WALK_LEFT: begin
            if (bump_right) begin
                next_state = STATE_WALK_RIGHT;
            end
            else if (!ground) begin
                next_state = STATE_FALLING;
            end
            else if (dig && ground) begin
                next_state = STATE_DIGGING;
            end
            else begin
                next_state = STATE_WALK_LEFT;
            end
        end
        STATE_WALK_RIGHT: begin
            if (bump_left) begin
                next_state = STATE_WALK_LEFT;
            end
            else if (!ground) begin
                next_state = STATE_FALLING;
            end
            else if (dig && ground) begin
                next_state = STATE_DIGGING;
            end
            else begin
                next_state = STATE_WALK_RIGHT;
            end
        end
        STATE_FALLING: begin
            if (ground) begin
                if (fall_counter >= 20) begin
                    next_state = STATE_SPLATTER;
                end
                else begin
                    if (bump_left) begin
                        next_state = STATE_WALK_RIGHT;
                    end
                    else if (bump_right) begin
                        next_state = STATE_WALK_LEFT;
                    end
                    else begin
                        next_state = state;
                    end
                end
            end
            else begin
                next_state = STATE_FALLING;
            end
        end
        STATE_DIGGING: begin
            if (!ground) begin
                next_state = STATE_FALLING;
            end
            else begin
                next_state = STATE_DIGGING;
            end
        end
        STATE_SPLATTER: begin
            next_state = STATE_SPLATTER;
        end
        default: begin
            next_state = STATE_WALK_LEFT;
        end
    endcase
end

endmodule
