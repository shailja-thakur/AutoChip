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

parameter WALK_LEFT = 1'b1;
parameter WALK_RIGHT = 1'b0;

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
        aaah <= (state == WALK_LEFT || state == WALK_RIGHT) && !ground;
    end
end

always @(*) begin
    next_state = state;
    case (state)
        WALK_LEFT: begin
            if (bump_right) begin
                next_state = WALK_RIGHT;
            end
            else if (!ground) begin
                next_state = WALK_LEFT;
            end
        end
        WALK_RIGHT: begin
            if (bump_left) begin
                next_state = WALK_LEFT;
            end
            else if (!ground) begin
                next_state = WALK_RIGHT;
            end
        end
    endcase
end

endmodule
