module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

localparam WALK_LEFT = 1'b0, WALK_RIGHT = 1'b1;
reg state, next_state;

always @(posedge clk, posedge areset) begin
    if (areset)
        state <= WALK_LEFT;
    else
        state <= next_state;
end

always @(*) begin
    // Update next state based on current state and inputs
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
        default:
            next_state = WALK_LEFT;
    endcase
end

// Output logic
always @(*) begin
    walk_left = (state == WALK_LEFT);
    walk_right = (state == WALK_RIGHT);
end

endmodule
