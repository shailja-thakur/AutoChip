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

// Define the states
localparam [1:0] WALK_LEFT = 2'd0, WALK_RIGHT = 2'd1, FALLING = 2'd2;

// Internal state register
reg [1:0] state, next_state;

// Asynchronous reset
always @(posedge areset) begin
    state <= WALK_LEFT;
    walk_left <= 1;
    walk_right <= 0;
    aaah <= 0;
end

// State transition logic
always @(*) begin
    next_state = state;
    case (state)
        WALK_LEFT: begin
            walk_left = 1;
            walk_right = 0;
            aaah = 0;
            if (bump_right) next_state = WALK_RIGHT;
            else if (!ground) next_state = FALLING;
        end
        WALK_RIGHT: begin
            walk_left = 0;
            walk_right = 1;
            aaah = 0;
            if (bump_left) next_state = WALK_LEFT;
            else if (!ground) next_state = FALLING;
        end
        FALLING: begin
            walk_left = 0;
            walk_right = 0;
            aaah = 1;
            if (ground) next_state = (walk_left) ? WALK_LEFT : WALK_RIGHT;
        end
    endcase
end

// State update logic
always @(posedge clk) begin
    state <= next_state;
end

endmodule
