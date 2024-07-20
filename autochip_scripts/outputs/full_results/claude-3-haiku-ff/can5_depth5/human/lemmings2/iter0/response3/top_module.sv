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

// State encoding
localparam WALK_LEFT = 2'b00;
localparam WALK_RIGHT = 2'b01;
localparam FALLING = 2'b10;

reg [1:0] state, next_state;

always @(*) begin
    // Default outputs
    walk_left = 1'b0;
    walk_right = 1'b0;
    aaah = 1'b0;

    // Next state logic
    case (state)
        WALK_LEFT: begin
            walk_left = 1'b1;
            if (bump_right)
                next_state = WALK_RIGHT;
            else if (!ground)
                next_state = FALLING;
            else
                next_state = WALK_LEFT;
        end
        WALK_RIGHT: begin
            walk_right = 1'b1;
            if (bump_left)
                next_state = WALK_LEFT;
            else if (!ground)
                next_state = FALLING;
            else
                next_state = WALK_RIGHT;
        end
        FALLING: begin
            aaah = 1'b1;
            if (ground)
                next_state = state; // Resume previous direction
            else
                next_state = FALLING;
        end
        default: next_state = WALK_LEFT;
    endcase
end

always @(posedge clk, posedge areset) begin
    if (areset)
        state <= WALK_LEFT;
    else
        state <= next_state;
end

endmodule
