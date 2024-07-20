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

localparam [2:0] STATE_WALK_LEFT = 3'd0,
                 STATE_WALK_RIGHT = 3'd1,
                 STATE_FALL = 3'd2,
                 STATE_DIG = 3'd3,
                 STATE_SPLATTER = 3'd4;

reg [2:0] state, next_state;
reg [4:0] fall_count;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= STATE_WALK_LEFT;
        walk_left <= 1'b1;
        walk_right <= 1'b0;
        aaah <= 1'b0;
        digging <= 1'b0;
        fall_count <= 5'b0;
    end
    else begin
        state <= next_state;
        walk_left <= (state == STATE_WALK_LEFT);
        walk_right <= (state == STATE_WALK_RIGHT);
        aaah <= (state == STATE_FALL);
        digging <= (state == STATE_DIG);
        if (next_state == STATE_FALL) begin
            fall_count <= fall_count + 1'b1;
        end
        else begin
            fall_count <= 5'b0;
        end
    end
end

always @(*) begin
    case (state)
        STATE_WALK_LEFT: begin
            if (ground == 1'b0) begin
                next_state = STATE_FALL;
            end
            else if (bump_right == 1'b1) begin
                next_state = STATE_WALK_RIGHT;
            end
            else if (dig == 1'b1 && ground == 1'b1) begin
                next_state = STATE_DIG;
            end
            else begin
                next_state = STATE_WALK_LEFT;
            end
        end
        STATE_WALK_RIGHT: begin
            if (ground == 1'b0) begin
                next_state = STATE_FALL;
            end
            else if (bump_left == 1'b1) begin
                next_state = STATE_WALK_LEFT;
            end
            else if (dig == 1'b1 && ground == 1'b1) begin
                next_state = STATE_DIG;
            end
            else begin
                next_state = STATE_WALK_RIGHT;
            end
        end
        STATE_FALL: begin
            if (ground == 1'b1) begin
                if (fall_count >= 20) begin
                    next_state = STATE_SPLATTER;
                end
                else begin
                    if (walk_left == 1'b1) begin
                        next_state = STATE_WALK_LEFT;
                    end
                    else begin
                        next_state = STATE_WALK_RIGHT;
                    end
                end
            end
            else begin
                next_state = STATE_FALL;
            end
        end
        STATE_DIG: begin
            if (ground == 1'b0) begin
                next_state = STATE_FALL;
            end
            else if (dig == 1'b0) begin
                next_state = (walk_left) ? STATE_WALK_LEFT : STATE_WALK_RIGHT;
            end
            else begin
                next_state = STATE_DIG;
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
