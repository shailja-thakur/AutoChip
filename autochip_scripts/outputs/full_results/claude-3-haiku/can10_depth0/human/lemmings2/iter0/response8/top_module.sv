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

localparam STATE_WALKING_LEFT = 1'b0;
localparam STATE_WALKING_RIGHT = 1'b1;

reg current_state, next_state;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        current_state <= STATE_WALKING_LEFT;
    end
    else begin
        current_state <= next_state;
    end
end

always @(*) begin
    next_state = current_state;
    walk_left = 0;
    walk_right = 0;
    aaah = 0;

    case (current_state)
        STATE_WALKING_LEFT: begin
            walk_left = 1;
            if (bump_right) begin
                next_state = STATE_WALKING_RIGHT;
            end
            else if (!ground) begin
                aaah = 1;
            end
        end
        STATE_WALKING_RIGHT: begin
            walk_right = 1;
            if (bump_left) begin
                next_state = STATE_WALKING_LEFT;
            end
            else if (!ground) begin
                aaah = 1;
            end
        end
    endcase

    if (!ground) begin
        walk_left = 0;
        walk_right = 0;
    end
    else if (ground && current_state == STATE_WALKING_LEFT) begin
        walk_left = 1;
    end
    else if (ground && current_state == STATE_WALKING_RIGHT) begin
        walk_right = 1;
    end
end

endmodule
