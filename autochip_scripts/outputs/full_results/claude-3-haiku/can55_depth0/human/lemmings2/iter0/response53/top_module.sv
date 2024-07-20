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

localparam STATE_WALK_LEFT = 1'b0;
localparam STATE_WALK_RIGHT = 1'b1;

reg current_state, next_state;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        current_state <= STATE_WALK_LEFT;
        walk_left <= 1'b1;
        walk_right <= 1'b0;
        aaah <= 1'b0;
    end
    else begin
        current_state <= next_state;
        walk_left <= (current_state == STATE_WALK_LEFT) ? 1'b1 : 1'b0;
        walk_right <= (current_state == STATE_WALK_RIGHT) ? 1'b1 : 1'b0;
        aaah <= (ground == 1'b0) ? 1'b1 : 1'b0;
    end
end

always @(*) begin
    case (current_state)
        STATE_WALK_LEFT: begin
            if (bump_right) begin
                next_state = STATE_WALK_RIGHT;
            end
            else begin
                next_state = STATE_WALK_LEFT;
            end
        end
        STATE_WALK_RIGHT: begin
            if (bump_left) begin
                next_state = STATE_WALK_LEFT;
            end
            else begin
                next_state = STATE_WALK_RIGHT;
            end
        end
        default: begin
            next_state = STATE_WALK_LEFT;
        end
    endcase
end

endmodule
