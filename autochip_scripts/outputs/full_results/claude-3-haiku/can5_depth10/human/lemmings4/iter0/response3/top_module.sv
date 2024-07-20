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

reg [4:0] fall_count;

parameter WALK_LEFT = 0, WALK_RIGHT = 1, FALLING = 2, DIGGING = 3;
reg [1:0] state, next_state;

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
        case (state)
            WALK_LEFT: begin
                walk_left <= 1;
                walk_right <= 0;
                aaah <= 0;
                digging <= 0;
                fall_count <= 0;
            end
            WALK_RIGHT: begin
                walk_left <= 0;
                walk_right <= 1;
                aaah <= 0;
                digging <= 0;
                fall_count <= 0;
            end
            FALLING: begin
                walk_left <= 0;
                walk_right <= 0;
                aaah <= 1;
                digging <= 0;
                fall_count <= fall_count + 1;
            end
            DIGGING: begin
                walk_left <= 0;
                walk_right <= 0;
                aaah <= 0;
                digging <= 1;
                fall_count <= 0;
            end
        endcase
    end
end

always @(*) begin
    next_state = state;
    case (state)
        WALK_LEFT: begin
            if (bump_right) next_state = WALK_RIGHT;
            else if (!ground) next_state = FALLING;
            else if (dig && ground) next_state = DIGGING;
        end
        WALK_RIGHT: begin
            if (bump_left) next_state = WALK_LEFT;
            else if (!ground) next_state = FALLING;
            else if (dig && ground) next_state = DIGGING;
        end
        FALLING: begin
            if (ground) next_state = (fall_count >= 20) ? WALK_LEFT : ((walk_left) ? WALK_LEFT : WALK_RIGHT);
        end
        DIGGING: begin
            if (!ground) next_state = FALLING;
            else if (!dig) next_state = (walk_left) ? WALK_LEFT : WALK_RIGHT;
        end
    endcase
end

endmodule
