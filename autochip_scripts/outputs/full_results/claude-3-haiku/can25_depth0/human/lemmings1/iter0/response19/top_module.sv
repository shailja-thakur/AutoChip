module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

localparam LEFT = 1'b0, RIGHT = 1'b1;
reg state, next_state;

// State update logic
always @(posedge clk, posedge areset) begin
    if (areset)
        state <= LEFT;
    else
        state <= next_state;
end

// Next state logic
always @(*) begin
    next_state = state;
    case (state)
        LEFT: begin
            if (bump_right)
                next_state = RIGHT;
        end
        RIGHT: begin
            if (bump_left)
                next_state = LEFT;
        end
    endcase
end

// Output logic
always @(*) begin
    walk_left = (state == LEFT);
    walk_right = (state == RIGHT);
end

endmodule
