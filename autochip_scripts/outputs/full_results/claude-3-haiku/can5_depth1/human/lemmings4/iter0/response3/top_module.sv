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

// Define the states of the finite state machine
parameter WALK_LEFT = 0, WALK_RIGHT = 1, FALLING = 2, DIGGING = 3;
reg [1:0] state, next_state;

// Fall counter
reg [4:0] fall_counter;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;
        walk_left <= 1;
        walk_right <= 0;
        aaah <= 0;
        digging <= 0;
        fall_counter <= 0;
    end
    else begin
        state <= next_state;
        walk_left <= (state == WALK_LEFT);
        walk_right <= (state == WALK_RIGHT);
        aaah <= (state == FALLING);
        digging <= (state == DIGGING);

        // Update the fall counter
        if (state == FALLING) begin
            fall_counter <= fall_counter + 1;
        end
        else begin
            fall_counter <= 0;
        end
    end
end

always @(*) begin
    next_state = state;
    case (state)
        WALK_LEFT: begin
            if (bump_right) begin
                next_state = WALK_RIGHT;
            end
            else if (!ground) begin
                next_state = FALLING;
            end
            else if (dig) begin
                next_state = DIGGING;
            end
        end
        WALK_RIGHT: begin
            if (bump_left) begin
                next_state = WALK_LEFT;
            end
            else if (!ground) begin
                next_state = FALLING;
            end
            else if (dig) begin
                next_state = DIGGING;
            end
        end
        FALLING: begin
            if (ground) begin
                if (fall_counter >= 20) begin
                    // Splatter
                    next_state = WALK_LEFT;
                    walk_left = 0;
                    walk_right = 0;
                    aaah = 0;
                    digging = 0;
                end
                else begin
                    next_state = (walk_left) ? WALK_LEFT : WALK_RIGHT;
                end
            end
        end
        DIGGING: begin
            if (!ground) begin
                next_state = FALLING;
            end
        end
    endcase
end

endmodule
