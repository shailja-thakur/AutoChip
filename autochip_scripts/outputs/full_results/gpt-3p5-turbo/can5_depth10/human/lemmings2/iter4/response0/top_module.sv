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

reg[1:0] current_state;
reg[1:0] next_state;
reg previous_ground;
reg previous_direction;
wire direction;
wire[1:0] bumped;

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
    case (current_state)
        WALK_LEFT: begin
            if (areset)
                next_state = WALK_LEFT;
            else if (bump_left || (ground && !previous_ground) || (ground && bump_left && bump_right))
                next_state = WALK_RIGHT;
            else
                next_state = WALK_LEFT;
        end
        WALK_RIGHT: begin
            if (areset)
                next_state = WALK_LEFT;
            else if (bump_right || (ground && !previous_ground) || (ground && bump_left && bump_right))
                next_state = WALK_LEFT;
            else
                next_state = WALK_RIGHT;
        end
        FALL: begin
            if (areset)
                next_state = WALK_LEFT;
            else if (ground && !previous_ground)
                next_state = previous_direction ? WALK_LEFT : WALK_RIGHT;
            else
                next_state = FALL;
        end
        default: next_state = WALK_LEFT;
    endcase
end

// Determine the direction based on the current state
assign direction = (current_state == WALK_RIGHT);

// Determine if the Lemming is bumped on either side
assign bumped[0] = bump_left;
assign bumped[1] = bump_right;

// Remember the previous ground state
always @(posedge clk or posedge areset) begin
    if (areset)
        previous_ground <= 1;
    else
        previous_ground <= ground;
end

// Remember the previous direction
always @(posedge clk or posedge areset) begin
    if (areset)
        previous_direction <= 0;
    else
        previous_direction <= direction;
end

endmodule
