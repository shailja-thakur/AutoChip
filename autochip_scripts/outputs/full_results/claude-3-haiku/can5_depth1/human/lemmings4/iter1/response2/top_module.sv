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
                 STATE_SPLATTER = 3'b100;

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
        walk_left <= (state == STATE_WALK_LEFT) ? 1'b1 : 1'b0;
        walk_right <= (state == STATE_WALK_RIGHT) ? 1'b1 : 1'b0;
        aaah <= (state == STATE_FALL) ? 1'b1 : 1'b0;
        digging <= (state == STATE_DIG) ? 1'b1 : 1'b0;
        if (state == STATE_FALL) begin
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
            if (bump_right) begin
                next_state = STATE_WALK_RIGHT;
            end
            else if (~ground) begin
                next_state = STATE_FALL;
            end
            else if (dig) begin
                next_state = STATE_DIG;
            end
            else begin
                next_state = STATE_WALK_LEFT;
            end
        end
        STATE_WALK_RIGHT: begin
            if (bump_left) begin
                next_state = STATE_WALK_LEFT;
            end
            else if (~ground) begin
                next_state = STATE_FALL;
            end
            else if (dig) begin
                next_state = STATE_DIG;
            end
            else begin
                next_state = STATE_WALK_RIGHT;
            end
        end
        STATE_FALL: begin
            if (ground) begin
                if (fall_count >= 20) begin
                    next_state = STATE_SPLATTER;
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
            else begin
                next_state = STATE_FALL;
            end
        end
        STATE_DIG: begin
            if (~ground) begin
                next_state = STATE_FALL;
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
