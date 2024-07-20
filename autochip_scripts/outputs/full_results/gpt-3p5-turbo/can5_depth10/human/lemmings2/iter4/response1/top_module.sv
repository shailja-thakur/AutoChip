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
wire direction;
wire [1:0] bumped;

// State encoding
parameter WALK_LEFT = 2'b00;
parameter WALK_RIGHT = 2'b01;
parameter FALL = 2'b10;

// Define the output signals
always @(current_state) begin
    case (current_state)
        WALK_LEFT: begin
            walk_left = 1'b1;
            walk_right = 1'b0;
            aaah = 1'b0;
        end
        WALK_RIGHT: begin
            walk_left = 1'b0;
            walk_right = 1'b1;
            aaah = 1'b0;
        end
        FALL: begin
            walk_left = previous_direction;
            walk_right = ~previous_direction;
            aaah = 1'b1;
        end
        default: begin
            walk_left = 1'b0;
            walk_right = 1'b0;
            aaah = 1'b0;
        end
    endcase
end

// Determine the next state based on the current state and inputs
always @(posedge clk or posedge areset) begin
    if (areset) begin
        current_state <= WALK_LEFT;
        previous_ground <= 1'b0;
    end
    else begin
        current_state <= next_state;
        previous_ground <= ground;
    end
end

// Define the next state logic
always @* begin
    next_state = current_state;

    if (ground && !previous_ground) begin
        if (previous_direction)
            next_state = WALK_LEFT;
        else
            next_state = WALK_RIGHT;
    end
    else if (ground && previous_ground) begin
        if (bump_left && !bump_right)
            next_state = WALK_RIGHT;
        else if (!bump_left && bump_right)
            next_state = WALK_LEFT;
        else if (bump_left && bump_right)
            next_state = WALK_RIGHT;
    end
    else if (!ground && current_state != FALL)
        next_state = FALL;
end

// Determine the direction based on the current state
assign direction = (current_state == WALK_RIGHT);

// Determine if the Lemming is bumped on either side
assign bumped[0] = bump_left;
assign bumped[1] = bump_right;

endmodule
