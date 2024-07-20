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

parameter WALK_LEFT = 0, WALK_RIGHT = 1, FALL = 2, DIG = 3, SPLATTER = 4;
reg [2:0] state, next_state;
reg [4:0] fall_counter;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;
        walk_left <= 1;
        walk_right <= 0;
        aaah <= 0;
        digging <= 0;
        fall_counter <= 0;
    end
    else begin
        state <= next_state;
        walk_left <= (state == WALK_LEFT) ? 1 : 0;
        walk_right <= (state == WALK_RIGHT) ? 1 : 0;
        aaah <= (state == FALL) ? 1 : 0;
        digging <= (state == DIG) ? 1 : 0;
        if (state == FALL) begin
            fall_counter <= fall_counter + 1;
        end
        else begin
            fall_counter <= 0;
        end
    end
end

always @(*) begin
    case (state)
        WALK_LEFT: begin
            if (bump_right) begin
                next_state = WALK_RIGHT;
            end
            else if (!ground) begin
                next_state = FALL;
            end
            else if (dig) begin
                next_state = DIG;
            end
            else begin
                next_state = WALK_LEFT;
            end
        end
        WALK_RIGHT: begin
            if (bump_left) begin
                next_state = WALK_LEFT;
            end
            else if (!ground) begin
                next_state = FALL;
            end
            else if (dig) begin
                next_state = DIG;
            end
            else begin
                next_state = WALK_RIGHT;
            end
        end
        FALL: begin
            if (ground) begin
                if (fall_counter >= 20) begin
                    next_state = SPLATTER;
                end
                else begin
                    if (walk_left) begin
                        next_state = WALK_LEFT;
                    end
                    else begin
                        next_state = WALK_RIGHT;
                    end
                end
            end
            else begin
                next_state = FALL;
            end
        end
        DIG: begin
            if (!ground) begin
                next_state = FALL;
            end
            else begin
                next_state = DIG;
            end
        end
        SPLATTER: begin
            next_state = SPLATTER;
        end
        default: begin
            next_state = WALK_LEFT;
        end
    endcase
end

endmodule
