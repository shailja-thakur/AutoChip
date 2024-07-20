module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

parameter STATE_WALK_LEFT = 1'b0;
parameter STATE_WALK_RIGHT = 1'b1;

reg state, next_state;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= STATE_WALK_LEFT;
        walk_left <= 1'b1;
        walk_right <= 1'b0;
    end
    else begin
        state <= next_state;
        case (state)
            STATE_WALK_LEFT: begin
                walk_left <= 1'b1;
                walk_right <= 1'b0;
            end
            STATE_WALK_RIGHT: begin
                walk_left <= 1'b0;
                walk_right <= 1'b1;
            end
            default: begin
                walk_left <= 1'b0;
                walk_right <= 1'b0;
            end
        endcase
    end
end

always @(*) begin
    next_state = state;
    case (state)
        STATE_WALK_LEFT: begin
            if (bump_right) begin
                next_state = STATE_WALK_RIGHT;
            end
        end
        STATE_WALK_RIGHT: begin
            if (bump_left) begin
                next_state = STATE_WALK_LEFT;
            end
        end
    endcase
end

endmodule
