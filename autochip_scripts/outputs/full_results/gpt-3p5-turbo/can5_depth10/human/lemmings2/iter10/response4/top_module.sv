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
    walk_left <= (current_state == WALK_LEFT);
    walk_right <= (current_state == WALK_RIGHT);
    aaah <= (current_state == FALL);
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
    next_state = current_state;

    if (areset) begin
        previous_ground <= 1'b0;
        bumped <= 2'b00;
    end
    else begin
        previous_ground <= ground;
        bumped <= {bump_left, bump_right};
    end

    if (ground && !previous_ground) begin
        if (current_state == WALK_LEFT)
            next_state = WALK_RIGHT;
        else if (current_state == WALK_RIGHT)
            next_state = WALK_LEFT;
    end
    else if (ground && previous_ground) begin
        if (bumped == 2'b10)
            next_state = WALK_LEFT;
        else if (bumped == 2'b01 || bumped == 2'b11)
            next_state = WALK_RIGHT;
    end
    else if (!ground && current_state != FALL) begin
        next_state = FALL;
        direction <= (current_state == WALK_RIGHT);
    end
end

// Initial values
initial begin
    walk_left <= 1'b0;
    walk_right <= 1'b0;
    aaah <= 1'b0;
end

endmodule
