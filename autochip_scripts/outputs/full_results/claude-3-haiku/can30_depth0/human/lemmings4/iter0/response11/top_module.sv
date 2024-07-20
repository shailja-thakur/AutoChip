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
parameter WALK_LEFT = 0, WALK_RIGHT = 1, FALLING = 2, DIGGING = 3;
reg [1:0] state, next_state;

// Counter for the fall duration
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

        // Update outputs based on the state
        case (state)
            WALK_LEFT: begin
                walk_left <= 1;
                walk_right <= 0;
                aaah <= 0;
                digging <= 0;
            end
            WALK_RIGHT: begin
                walk_left <= 0;
                walk_right <= 1;
                aaah <= 0;
                digging <= 0;
            end
            FALLING: begin
                walk_left <= 0;
                walk_right <= 0;
                aaah <= 1;
                digging <= 0;
                if (fall_counter < 20)
                    fall_counter <= fall_counter + 1;
                else
                    fall_counter <= 20;
            end
            DIGGING: begin
                walk_left <= 0;
                walk_right <= 0;
                aaah <= 0;
                digging <= 1;
            end
        endcase
    end
end

// Update the next state
always @(*) begin
    case (state)
        WALK_LEFT: begin
            if (bump_right)
                next_state = WALK_RIGHT;
            else if (!ground)
                next_state = FALLING;
            else if (dig && ground)
                next_state = DIGGING;
            else
                next_state = WALK_LEFT;
        end
        WALK_RIGHT: begin
            if (bump_left)
                next_state = WALK_LEFT;
            else if (!ground)
                next_state = FALLING;
            else if (dig && ground)
                next_state = DIGGING;
            else
                next_state = WALK_RIGHT;
        end
        FALLING: begin
            if (ground)
                next_state = (walk_left) ? WALK_LEFT : WALK_RIGHT;
            else
                next_state = FALLING;
        end
        DIGGING: begin
            if (!ground)
                next_state = FALLING;
            else if (!dig)
                next_state = (walk_left) ? WALK_LEFT : WALK_RIGHT;
            else
                next_state = DIGGING;
        end
    endcase
end

endmodule
