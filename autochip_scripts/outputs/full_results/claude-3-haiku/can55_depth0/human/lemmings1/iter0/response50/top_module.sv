module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

// Define the state encoding
parameter STATE_WALK_LEFT = 1'b0;
parameter STATE_WALK_RIGHT = 1'b1;

// Declare the state register
reg state;

// Implement the state machine
always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= STATE_WALK_LEFT;
        walk_left <= 1'b1;
        walk_right <= 1'b0;
    end
    else begin
        case (state)
            STATE_WALK_LEFT: begin
                walk_left <= 1'b1;
                walk_right <= 1'b0;
                if (bump_right)
                    state <= STATE_WALK_RIGHT;
            end
            STATE_WALK_RIGHT: begin
                walk_left <= 1'b0;
                walk_right <= 1'b1;
                if (bump_left)
                    state <= STATE_WALK_LEFT;
            end
        endcase
    end
end

endmodule
