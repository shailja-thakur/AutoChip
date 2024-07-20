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

reg [1:0] current_state;
reg [1:0] next_state;
reg previous_ground;
reg [1:0] previous_direction;

// State encoding
parameter WALK_LEFT = 2'b00;
parameter WALK_RIGHT = 2'b01;
parameter FALL = 2'b10;

// Define the output signals

// Determine the next state based on the current state and inputs
always @(posedge clk or posedge areset) begin
    if (areset)
        current_state <= WALK_LEFT;
    else
        current_state <= next_state;
end

// Define the next state logic
always @* begin
    next_state = current_state;
    previous_ground = ground;
    previous_direction = next_state;

    if (ground && !previous_ground) begin
        if (previous_direction == WALK_LEFT)
            next_state = WALK_RIGHT;
        else
            next_state = WALK_LEFT;
    end
    else if (ground && previous_ground) begin
        if (bump_left && !bump_right)
            next_state = WALK_RIGHT;
        else if (!bump_left && bump_right)
            next_state = WALK_LEFT;
        else if (bump_left && bump_right)
            next_state = WALK_RIGHT;
    end
    else if (!ground && !bump_left && !bump_right)
        next_state = FALL;
end

// Determine the direction based on the current state
always @* begin
    if (current_state == WALK_RIGHT) begin
        walk_left = 0;
        walk_right = 1;
    end
    else if (current_state == WALK_LEFT) begin
        walk_left = 1;
        walk_right = 0;
    end
    else if (current_state == FALL) begin
        walk_left = 0;
        walk_right = 0;
    end
end

// Determine if the Lemming is bumped on either side
always @* begin
    if (bump_left && !bump_right && current_state != FALL)
        aaah = 0;
    else if (!bump_left && bump_right && current_state != FALL)
        aaah = 0;
    else
        aaah = 1;
end

endmodule
