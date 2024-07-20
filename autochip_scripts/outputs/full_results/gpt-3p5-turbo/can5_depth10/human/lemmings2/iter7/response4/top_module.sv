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
wire direction;
reg [1:0] bumped;

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
        previous_ground <= ground;
        bumped <= 2'b00;
    end
    else begin
        previous_ground <= ground;
        bumped <= {bump_left, bump_right};
    end

    if (ground && !previous_ground) begin
        if (current_state == WALK_LEFT)
            next_state = WALK_RIGHT;
        else
            next_state = WALK_LEFT;
    end
    else if (ground && previous_ground) begin
        if (bumped == 2'b01)
            next_state = WALK_LEFT;
        else if (bumped == 2'b10)
            next_state = WALK_RIGHT;
        else if (bumped == 2'b11)
            next_state = WALK_RIGHT;
    end
    else if (!ground && current_state != FALL)
        next_state = FALL;
end

// Determine the direction based on the current state
always @(posedge clk) begin
    direction <= (current_state == WALK_RIGHT);
end

endmodule
