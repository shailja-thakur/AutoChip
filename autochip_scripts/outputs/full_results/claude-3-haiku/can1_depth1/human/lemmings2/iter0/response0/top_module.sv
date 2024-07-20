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

// Define the state parameters
parameter WALK_LEFT = 1'b0;
parameter WALK_RIGHT = 1'b1;

// Define the current and next state variables
reg state, next_state;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;
        walk_left <= 1'b1;
        walk_right <= 1'b0;
        aaah <= 1'b0;
    end
    else begin
        state <= next_state;
        walk_left <= (state == WALK_LEFT);
        walk_right <= (state == WALK_RIGHT);
        aaah <= (~ground);
    end
end

always @(*) begin
    // Next state logic
    case (state)
        WALK_LEFT: begin
            if (bump_right) begin
                next_state = WALK_RIGHT;
            end
            else begin
                next_state = WALK_LEFT;
            end
        end
        WALK_RIGHT: begin
            if (bump_left) begin
                next_state = WALK_LEFT;
            end
            else begin
                next_state = WALK_RIGHT;
            end
        end
        default: begin
            next_state = WALK_LEFT;
        end
    endcase
end

endmodule
