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
reg direction;
reg [1:0] bumped;

// State encoding
parameter WALK_LEFT = 2'b00;
parameter WALK_RIGHT = 2'b01;
parameter FALL = 2'b10;

// Define the output signals
always @(current_state) begin
    walk_left = (current_state == WALK_LEFT);
    walk_right = (current_state == WALK_RIGHT);
    aaah = (current_state == FALL);
end

// Determine the next state and direction based on the current state and inputs
always @(posedge clk or posedge areset) begin
    if (areset)
        current_state <= WALK_LEFT;
    else
        current_state <= next_state;
end

// Define the next state logic
always @* begin
    case (current_state)
        WALK_LEFT: begin
            if (ground)
                next_state = WALK_RIGHT;
            else if (bump_left)
                next_state = WALK_RIGHT;
            else if (bump_right)
                next_state = WALK_LEFT;
            else if (!ground)
                next_state = FALL;
        end
        WALK_RIGHT: begin
            if (ground)
                next_state = WALK_LEFT;
            else if (bump_left)
                next_state = WALK_LEFT;
            else if (bump_right)
                next_state = WALK_RIGHT;
            else if (!ground)
                next_state = FALL;
        end
        FALL: begin
            if (ground)
                next_state = (direction) ? WALK_RIGHT : WALK_LEFT;
        end
    endcase
end

endmodule
