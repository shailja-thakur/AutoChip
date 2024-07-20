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

parameter INIT = 0, WALK_LEFT = 1, WALK_RIGHT = 2, FALL = 3, DIG = 4, SPLATTER = 5;
reg [2:0] state, next_state;
reg [4:0] fall_counter;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= INIT;
        walk_left <= 1;
        walk_right <= 0;
        aaah <= 0;
        digging <= 0;
        fall_counter <= 0;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    next_state = state;
    case (state)
        INIT: begin
            walk_left = 1;
            walk_right = 0;
            aaah = 0;
            digging = 0;
            next_state = WALK_LEFT;
        end
        WALK_LEFT: begin
            walk_left = 1;
            walk_right = 0;
            if (bump_right) begin
                next_state = WALK_RIGHT;
            end
            else if (!ground) begin
                next_state = FALL;
                fall_counter = 0;
            end
            else if (dig) begin
                next_state = DIG;
            end
        end
        WALK_RIGHT: begin
            walk_left = 0;
            walk_right = 1;
            if (bump_left) begin
                next_state = WALK_LEFT;
            end
            else if (!ground) begin
                next_state = FALL;
                fall_counter = 0;
            end
            else if (dig) begin
                next_state = DIG;
            end
        end
        FALL: begin
            walk_left = 0;
            walk_right = 0;
            aaah = 1;
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
                fall_counter = fall_counter + 1;
            end
        end
        DIG: begin
            walk_left = 0;
            walk_right = 0;
            aaah = 0;
            digging = 1;
            if (!ground) begin
                next_state = FALL;
                fall_counter = 0;
            end
        end
        SPLATTER: begin
            walk_left = 0;
            walk_right = 0;
            aaah = 0;
            digging = 0;
        end
    endcase
end

endmodule
