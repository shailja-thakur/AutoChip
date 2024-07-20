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
reg switched_direction;

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

// Determine the next state logic
always @(current_state or ground or previous_ground or bump_left or bump_right) begin
    case (current_state)
        WALK_LEFT: begin
            if (bump_right)
                next_state = WALK_RIGHT;
            else if (!ground)
                next_state = FALL;
            else
                next_state = WALK_LEFT;
        end
        WALK_RIGHT: begin
            if (bump_left)
                next_state = WALK_LEFT;
            else if (!ground)
                next_state = FALL;
            else
                next_state = WALK_RIGHT;
        end
        FALL: begin
            if (ground && !previous_ground)
                next_state = switched_direction ? WALK_RIGHT : WALK_LEFT;
            else if (!ground)
                next_state = FALL;
            else
                next_state = previous_direction ? WALK_RIGHT : WALK_LEFT;
        end
        default: next_state = WALK_LEFT;
    endcase
end

// Update previous ground and direction
always @(posedge clk or posedge areset) begin
    if (areset)
        previous_ground <= 0;
    else
        previous_ground <= ground;

    previous_direction <= current_state[0];
    switched_direction <= (current_state != next_state);
end

endmodule
