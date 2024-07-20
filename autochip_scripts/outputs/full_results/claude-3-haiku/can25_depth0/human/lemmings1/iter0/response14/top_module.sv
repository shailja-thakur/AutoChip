module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

// Define the two states
parameter STATE_WALK_LEFT = 1'b0;
parameter STATE_WALK_RIGHT = 1'b1;

// Current state
reg state;

// Reset the machine to walking left
always @(posedge areset) begin
    state <= STATE_WALK_LEFT;
    walk_left <= 1'b1;
    walk_right <= 1'b0;
end

// Update the state machine
always @(posedge clk) begin
    case (state)
        STATE_WALK_LEFT: begin
            walk_left <= 1'b1;
            walk_right <= 1'b0;
            if (bump_right) begin
                state <= STATE_WALK_RIGHT;
            end
        end
        STATE_WALK_RIGHT: begin
            walk_left <= 1'b0;
            walk_right <= 1'b1;
            if (bump_left) begin
                state <= STATE_WALK_LEFT;
            end
        end
    endcase
end

endmodule
