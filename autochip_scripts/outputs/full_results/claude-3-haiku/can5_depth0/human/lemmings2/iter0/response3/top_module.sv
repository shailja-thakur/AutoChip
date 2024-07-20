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

// State transition logic
always @(*) begin
    next_state = current_state;
    if (areset) begin
        next_state = STATE_WALK_LEFT;
    end else if (bump_left) begin
        next_state = STATE_WALK_RIGHT;
    end else if (bump_right) begin
        next_state = STATE_WALK_LEFT;
    end
end

// Output logic
always @(*) begin
    walk_left = 0;
    walk_right = 0;
    aaah = 0;
    case (next_state)
        STATE_WALK_LEFT: begin
            walk_left = 1;
        end
        STATE_WALK_RIGHT: begin
            walk_right = 1;
        end
    endcase
    if (!ground) begin
        aaah = 1;
    end
end

// State register
always @(posedge clk, posedge areset) begin
    if (areset) begin
        current_state <= STATE_WALK_LEFT;
    end else begin
        current_state <= next_state;
    end
end

endmodule
