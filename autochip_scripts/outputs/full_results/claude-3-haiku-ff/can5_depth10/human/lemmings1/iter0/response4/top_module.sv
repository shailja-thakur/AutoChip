module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

// Define the two states of the finite state machine
parameter WALK_LEFT = 1'b0;
parameter WALK_RIGHT = 1'b1;

// Define the current and next states
reg state, next_state;

// Combinational logic for next state
always @(*) begin
    case (state)
        WALK_LEFT: begin
            if (bump_left)
                next_state = WALK_RIGHT;
            else if (bump_right)
                next_state = WALK_RIGHT;
            else
                next_state = WALK_LEFT;
        end
        WALK_RIGHT: begin
            if (bump_right)
                next_state = WALK_LEFT;
            else if (bump_left)
                next_state = WALK_LEFT;
            else
                next_state = WALK_RIGHT;
        end
        default: next_state = WALK_LEFT;
    endcase
end

// Sequential logic for state update
always @(posedge clk or posedge areset) begin
    if (areset)
        state <= WALK_LEFT;
    else
        state <= next_state;
end

// Combinational logic for output
always @(*) begin
    walk_left = (state == WALK_LEFT);
    walk_right = (state == WALK_RIGHT);
end

endmodule
