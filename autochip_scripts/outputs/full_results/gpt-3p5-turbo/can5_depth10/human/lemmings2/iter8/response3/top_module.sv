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
        bumped <= 2'b00;
    end
    else begin
        previous_ground <= ground;
        bumped <= {bump_left, bump_right};
    end

    case (current_state)
        WALK_LEFT: begin
            if (bump_right)
                next_state = WALK_RIGHT;
        end
        WALK_RIGHT: begin
            if (bump_left)
                next_state = WALK_LEFT;
        end
        FALL: begin
            if (ground)
                next_state = direction ? WALK_RIGHT : WALK_LEFT;
        end
    endcase
end

// Determine the direction based on the current state
always @(posedge clk) begin
    if (current_state == WALK_RIGHT || (current_state == FALL && direction))
        direction <= 1'b1;
    else if (current_state == WALK_LEFT || (current_state == FALL && !direction))
        direction <= 1'b0;
end

endmodule
