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
    next_state = current_state;

    if (areset) begin
        previous_ground <= 1'b0;
    end else begin
        previous_ground <= ground;
    end

    if (ground && !previous_ground) begin
        if (current_state == WALK_LEFT) begin
            next_state = WALK_RIGHT;
        end else begin
            next_state = WALK_LEFT;
        end
    end else if (ground && previous_ground) begin
        if (bump_left && !bump_right) begin
            next_state = WALK_RIGHT;
        end else if (!bump_left && bump_right) begin
            next_state = WALK_LEFT;
        end else if (bump_left && bump_right) begin
            next_state = WALK_RIGHT;
        end
    end else if (!ground && current_state != FALL) begin
        next_state = FALL;
    end
end

// Determine the direction based on the current state
assign direction = (current_state == WALK_RIGHT);

// Determine if the Lemming is bumped on either side
assign bumped[0] = bump_left;
assign bumped[1] = bump_right;

endmodule
