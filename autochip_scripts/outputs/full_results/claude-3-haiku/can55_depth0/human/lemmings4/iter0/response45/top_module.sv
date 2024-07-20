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

// Define the states of the Lemming's finite state machine
typedef enum {WALK_LEFT, WALK_RIGHT, FALL, DIG} state_t;
state_t state, next_state;

// Counter for fall duration
reg [4:0] fall_count;

// Reset the Lemming state machine when areset is asserted
always @(posedge areset) begin
    state <= WALK_LEFT;
    walk_left <= 1;
    walk_right <= 0;
    aaah <= 0;
    digging <= 0;
    fall_count <= 0;
end

// Update the Lemming state and outputs based on the current state and inputs
always @(posedge clk) begin
    state <= next_state;

    case (state)
        WALK_LEFT: begin
            walk_left <= 1;
            walk_right <= 0;
            aaah <= 0;
            digging <= 0;
            fall_count <= 0;

            if (bump_right)
                next_state <= WALK_RIGHT;
            else if (!ground)
                next_state <= FALL;
            else if (dig)
                next_state <= DIG;
            else
                next_state <= WALK_LEFT;
        end

        WALK_RIGHT: begin
            walk_left <= 0;
            walk_right <= 1;
            aaah <= 0;
            digging <= 0;
            fall_count <= 0;

            if (bump_left)
                next_state <= WALK_LEFT;
            else if (!ground)
                next_state <= FALL;
            else if (dig)
                next_state <= DIG;
            else
                next_state <= WALK_RIGHT;
        end

        FALL: begin
            walk_left <= 0;
            walk_right <= 0;
            aaah <= 1;
            digging <= 0;
            fall_count <= fall_count + 1;

            if (ground)
                next_state <= (walk_left) ? WALK_LEFT : WALK_RIGHT;
            else if (fall_count == 20)
                next_state <= WALK_LEFT; // Splatter, reset to walk left
            else
                next_state <= FALL;
        end

        DIG: begin
            walk_left <= 0;
            walk_right <= 0;
            aaah <= 0;
            digging <= 1;

            if (!ground)
                next_state <= FALL;
            else if (dig)
                next_state <= DIG;
            else
                next_state <= (walk_left) ? WALK_LEFT : WALK_RIGHT;
        end

        default:
            next_state <= WALK_LEFT;
    endcase
end

endmodule
