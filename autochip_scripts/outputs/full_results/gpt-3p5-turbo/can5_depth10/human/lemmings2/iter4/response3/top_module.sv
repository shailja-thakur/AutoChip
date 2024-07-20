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
reg[1:0] bumped;

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
    if (areset) begin
        current_state <= WALK_LEFT;
    end
    else begin
        current_state <= next_state;
    end
end

// Define the next state logic
always @(current_state, previous_ground, bump_left, bump_right) begin
    next_state = current_state;
    case (current_state)
        WALK_LEFT: begin
            if (bump_right) begin
                next_state = WALK_RIGHT;
            end
            else if (!ground && previous_ground) begin
                next_state = FALL;
            end
        end
        WALK_RIGHT: begin
            if (bump_left) begin
                next_state = WALK_LEFT;
            end
            else if (!ground && previous_ground) begin
                next_state = FALL;
            end
        end
        FALL: begin
            if (ground && !previous_ground) begin
                next_state = previous_direction ? WALK_LEFT : WALK_RIGHT;
            end
        end
    endcase
end

// Determine the direction based on the current state
assign direction = (current_state == WALK_RIGHT);

// Determine if the Lemming is bumped on either side
assign bumped[0] = bump_left;
assign bumped[1] = bump_right;

endmodule
