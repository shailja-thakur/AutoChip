module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output reg walk_left,
    output reg walk_right,
    output reg aaah,
    output reg digging
);

// Define the states
parameter WALK_LEFT = 2'b00, WALK_RIGHT = 2'b01, FALL = 2'b10, DIG = 2'b11;
reg [1:0] state, next_state;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;
        walk_left <= 1;
        walk_right <= 0;
        aaah <= 0;
        digging <= 0;
    end
    else begin
        state <= next_state;
        walk_left <= (state == WALK_LEFT);
        walk_right <= (state == WALK_RIGHT);
        aaah <= (state == FALL);
        digging <= (state == DIG);
    end
end

always @(*) begin
    next_state = state; // Default to staying in the current state
    case (state)
        WALK_LEFT: begin
            if (bump_right)
                next_state = WALK_RIGHT;
            else if (!ground)
                next_state = FALL;
            else if (dig)
                next_state = DIG;
        end
        WALK_RIGHT: begin
            if (bump_left)
                next_state = WALK_LEFT;
            else if (!ground)
                next_state = FALL;
            else if (dig)
                next_state = DIG;
        end
        FALL: begin
            if (ground)
                next_state = (walk_left) ? WALK_LEFT : WALK_RIGHT;
        end
        DIG: begin
            if (!ground)
                next_state = FALL;
            else if (!dig)
                next_state = (walk_left) ? WALK_LEFT : WALK_RIGHT;
        end
    endcase
end

endmodule
