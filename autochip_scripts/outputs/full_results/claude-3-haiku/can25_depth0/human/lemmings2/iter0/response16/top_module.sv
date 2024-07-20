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
    end
    else begin
        current_state <= next_state;
    end
end

always @(*) begin
    next_state = current_state;
    walk_left = 1'b0;
    walk_right = 1'b0;
    aaah = 1'b0;

    case (current_state)
        STATE_WALK_LEFT: begin
            walk_left = 1'b1;
            if (ground == 1'b0) begin
                aaah = 1'b1;
                next_state = current_state;
            end
            else if (bump_right == 1'b1) begin
                next_state = STATE_WALK_RIGHT;
            end
        end
        STATE_WALK_RIGHT: begin
            walk_right = 1'b1;
            if (ground == 1'b0) begin
                aaah = 1'b1;
                next_state = current_state;
            end
            else if (bump_left == 1'b1) begin
                next_state = STATE_WALK_LEFT;
            end
        end
    endcase
end

endmodule
