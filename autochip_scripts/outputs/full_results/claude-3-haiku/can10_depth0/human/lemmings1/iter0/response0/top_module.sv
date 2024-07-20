module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

localparam STATE_WALK_LEFT = 1'b0;
localparam STATE_WALK_RIGHT = 1'b1;

reg current_state, next_state;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        current_state <= STATE_WALK_LEFT;
    end else begin
        current_state <= next_state;
    end
end

always @(*) begin
    case (current_state)
        STATE_WALK_LEFT: begin
            walk_left = 1'b1;
            walk_right = 1'b0;
            if (bump_left) begin
                next_state = STATE_WALK_RIGHT;
            end else if (bump_right) begin
                next_state = STATE_WALK_RIGHT;
            end else begin
                next_state = STATE_WALK_LEFT;
            end
        end
        STATE_WALK_RIGHT: begin
            walk_left = 1'b0;
            walk_right = 1'b1;
            if (bump_left) begin
                next_state = STATE_WALK_LEFT;
            end else if (bump_right) begin
                next_state = STATE_WALK_LEFT;
            end else begin
                next_state = STATE_WALK_RIGHT;
            end
        end
        default: begin
            walk_left = 1'b0;
            walk_right = 1'b0;
            next_state = STATE_WALK_LEFT;
        end
    endcase
end

endmodule
