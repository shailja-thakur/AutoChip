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

reg current_state, next_state;
parameter STATE_WALK_LEFT = 1'b0, STATE_WALK_RIGHT = 1'b1;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        current_state <= STATE_WALK_LEFT;
        walk_left <= 1'b1;
        walk_right <= 1'b0;
        aaah <= 1'b0;
    end
    else begin
        current_state <= next_state;
        walk_left <= (current_state == STATE_WALK_LEFT);
        walk_right <= (current_state == STATE_WALK_RIGHT);
        aaah <= (~ground);
    end
end

always @(*) begin
    case (current_state)
        STATE_WALK_LEFT: begin
            if (bump_left)
                next_state = STATE_WALK_RIGHT;
            else
                next_state = STATE_WALK_LEFT;
        end
        STATE_WALK_RIGHT: begin
            if (bump_right)
                next_state = STATE_WALK_LEFT;
            else
                next_state = STATE_WALK_RIGHT;
        end
        default: begin
            next_state = current_state;
        end
    endcase
end

endmodule
