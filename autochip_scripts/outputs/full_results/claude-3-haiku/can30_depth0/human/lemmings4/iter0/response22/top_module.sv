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

parameter WALK_LEFT = 2'b00, WALK_RIGHT = 2'b01, FALLING = 2'b10, DIGGING = 2'b11;
reg [1:0] state, next_state;
reg [4:0] fall_count;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;
        walk_left <= 1;
        walk_right <= 0;
        aaah <= 0;
        digging <= 0;
        fall_count <= 0;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    next_state = state;
    case (state)
        WALK_LEFT: begin
            walk_left = 1;
            walk_right = 0;
            aaah = 0;
            digging = 0;
            if (bump_right) begin
                next_state = WALK_RIGHT;
            end
            else if (!ground) begin
                next_state = FALLING;
                fall_count = 1;
            end
            else if (dig) begin
                next_state = DIGGING;
            end
        end
        WALK_RIGHT: begin
            walk_left = 0;
            walk_right = 1;
            aaah = 0;
            digging = 0;
            if (bump_left) begin
                next_state = WALK_LEFT;
            end
            else if (!ground) begin
                next_state = FALLING;
                fall_count = 1;
            end
            else if (dig) begin
                next_state = DIGGING;
            end
        end
        FALLING: begin
            walk_left = state == WALK_LEFT;
            walk_right = state == WALK_RIGHT;
            aaah = 1;
            digging = 0;
            if (ground) begin
                next_state = state;
                fall_count = 0;
            end
            else begin
                fall_count = fall_count + 1;
                if (fall_count == 20) begin
                    walk_left = 0;
                    walk_right = 0;
                    aaah = 0;
                    digging = 0;
                end
            end
        end
        DIGGING: begin
            walk_left = state == WALK_LEFT;
            walk_right = state == WALK_RIGHT;
            aaah = 0;
            digging = 1;
            if (!ground) begin
                next_state = FALLING;
                fall_count = 1;
            end
        end
    endcase
end
endmodule
