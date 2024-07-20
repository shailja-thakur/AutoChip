module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

// Define the states
parameter STATE_WALK_LEFT = 1'b0;
parameter STATE_WALK_RIGHT = 1'b1;

// Define the current and next states
reg current_state, next_state;

// Update the current state on the positive edge of the clock
always @(posedge clk, posedge areset) begin
    if (areset) begin
        current_state <= STATE_WALK_LEFT;
    end
    else begin
        current_state <= next_state;
    end
end

// Combinational logic to determine the next state
always @(*) begin
    case (current_state)
        STATE_WALK_LEFT: begin
            if (bump_right) begin
                next_state = STATE_WALK_RIGHT;
            end
            else begin
                next_state = STATE_WALK_LEFT;
            end
        end
        STATE_WALK_RIGHT: begin
            if (bump_left) begin
                next_state = STATE_WALK_LEFT;
            end
            else begin
                next_state = STATE_WALK_RIGHT;
            end
        end
        default: begin
            next_state = STATE_WALK_LEFT;
        end
    endcase
end

// Assign the output signals based on the current state
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
