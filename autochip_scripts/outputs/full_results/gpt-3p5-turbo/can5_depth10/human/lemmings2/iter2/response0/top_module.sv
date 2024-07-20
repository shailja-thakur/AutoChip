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
reg previous_direction;
wire [1:0] bumped;

// State encoding
parameter WALK_LEFT = 2'b00;
parameter WALK_RIGHT = 2'b01;
parameter FALL = 2'b10;

// Define the output signals
assign walk_left = (current_state == WALK_LEFT);
assign walk_right = (current_state == WALK_RIGHT);
assign aaah = (current_state == FALL);

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
    previous_direction = current_state;

    if (ground && !previous_ground && !bump_left && !bump_right) begin
        if (previous_direction == WALK_LEFT)
            next_state = WALK_RIGHT;
        else
            next_state = WALK_LEFT;
    end
    else if (!ground && !bump_left && !bump_right) begin
        if (previous_direction == WALK_LEFT && !previous_ground)
            next_state = FALL;
        else
            next_state = current_state;
    end
    else if (!ground && !bump_left && bump_right)
        next_state = WALK_LEFT;
    else if (!ground && bump_left && !bump_right)
        next_state = WALK_RIGHT;
    else if (!ground && bump_left && bump_right)
        next_state = WALK_RIGHT;
end

// Determine the direction based on the current state
always @(current_state) begin
    case (current_state)
        WALK_LEFT: walk_left = 1;
        WALK_RIGHT: walk_right = 1;
        default: walk_left = 0; walk_right = 0;
    endcase
end

// Determine if the Lemming is bumped on either side
assign bumped[0] = bump_left;
assign bumped[1] = bump_right;

endmodule
