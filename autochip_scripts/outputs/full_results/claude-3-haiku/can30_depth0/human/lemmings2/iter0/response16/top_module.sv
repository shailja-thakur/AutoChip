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

parameter WALK_LEFT = 1'b1, WALK_RIGHT = 1'b0;

reg state, next_state;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;
        walk_left <= 1;
        walk_right <= 0;
        aaah <= 0;
    end
    else begin
        state <= next_state;
        walk_left <= (state == WALK_LEFT);
        walk_right <= (state == WALK_RIGHT);
        aaah <= (~ground);
    end
end

always @(*) begin
    case (state)
        WALK_LEFT: begin
            if (bump_right)
                next_state = WALK_RIGHT;
            else
                next_state = WALK_LEFT;
        end
        WALK_RIGHT: begin
            if (bump_left)
                next_state = WALK_LEFT;
            else
                next_state = WALK_RIGHT;
        end
        default: begin
            next_state = state;
        end
    endcase
end

endmodule
