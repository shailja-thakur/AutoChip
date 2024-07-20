module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

// Define the states
localparam STATE_WALK_LEFT = 1'b0;
localparam STATE_WALK_RIGHT = 1'b1;

// Declare the state register
reg current_state, next_state;

// Combinational logic for next state
always @(*) begin
    case (current_state)
        STATE_WALK_LEFT: begin
            if (bump_right)
                next_state = STATE_WALK_RIGHT;
            else
                next_state = STATE_WALK_LEFT;
        end
        STATE_WALK_RIGHT: begin
            if (bump_left)
                next_state = STATE_WALK_LEFT;
            else
                next_state = STATE_WALK_RIGHT;
        end
        default:
            next_state = STATE_WALK_LEFT;
    endcase
end

// Sequential logic for state update
always @(posedge clk, posedge areset) begin
    if (areset)
        current_state <= STATE_WALK_LEFT;
    else
        current_state <= next_state;
end

// Output logic
always @(*) begin
    case (current_state)
        STATE_WALK_LEFT: begin
            walk_left = 1'b1;
            walk_right = 1'b0;
        end
        STATE_WALK_RIGHT: begin
            walk_left = 1'b0;
            walk_right = 1'b1;
        end
        default: begin
            walk_left = 1'b0;
            walk_right = 1'b0;
        end
    endcase
end

endmodule
