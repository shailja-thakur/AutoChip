module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    output reg walk_left,
    output reg walk_right,
    output reg aaah
);

// Define the states
typedef enum {LEFT, RIGHT, FALLING} state_t;
state_t state, next_state;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= LEFT;
        walk_left <= 1;
        walk_right <= 0;
        aaah <= 0;
    end
    else begin
        state <= next_state;
        walk_left <= (state == LEFT) ? 1 : 0;
        walk_right <= (state == RIGHT) ? 1 : 0;
        aaah <= (state == FALLING) ? 1 : 0;
    end
end

always @(*) begin
    case (state)
        LEFT: begin
            if (bump_right) begin
                next_state = RIGHT;
            end
            else if (~ground) begin
                next_state = FALLING;
            end
            else begin
                next_state = LEFT;
            end
        end
        RIGHT: begin
            if (bump_left) begin
                next_state = LEFT;
            end
            else if (~ground) begin
                next_state = FALLING;
            end
            else begin
                next_state = RIGHT;
            end
        end
        FALLING: begin
            if (ground) begin
                if (walk_left) begin
                    next_state = LEFT;
                end
                else begin
                    next_state = RIGHT;
                end
            end
            else begin
                next_state = FALLING;
            end
        end
        default: begin
            next_state = LEFT;
        end
    endcase
end

endmodule
