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

// Define the states of the Lemming FSM
typedef enum {
    STATE_WALK_LEFT,
    STATE_WALK_RIGHT,
    STATE_FALL,
    STATE_DIG
} lemming_state_t;

// Declare the current state variable
reg [1:0] current_state;

// Counter to keep track of the fall duration
reg [4:0] fall_count;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        current_state <= STATE_WALK_LEFT;
        walk_left <= 1;
        walk_right <= 0;
        aaah <= 0;
        digging <= 0;
        fall_count <= 0;
    end
    else begin
        case (current_state)
            STATE_WALK_LEFT: begin
                walk_left <= 1;
                walk_right <= 0;
                aaah <= 0;
                digging <= 0;
                fall_count <= 0;

                if (bump_right) begin
                    current_state <= STATE_WALK_RIGHT;
                end
                else if (!ground) begin
                    current_state <= STATE_FALL;
                end
                else if (dig) begin
                    current_state <= STATE_DIG;
                end
            end

            STATE_WALK_RIGHT: begin
                walk_left <= 0;
                walk_right <= 1;
                aaah <= 0;
                digging <= 0;
                fall_count <= 0;

                if (bump_left) begin
                    current_state <= STATE_WALK_LEFT;
                end
                else if (!ground) begin
                    current_state <= STATE_FALL;
                end
                else if (dig) begin
                    current_state <= STATE_DIG;
                end
            end

            STATE_FALL: begin
                walk_left <= 0;
                walk_right <= 0;
                aaah <= 1;
                digging <= 0;
                fall_count <= fall_count + 1;

                if (ground) begin
                    if (fall_count >= 20) begin
                        // Splatter
                        walk_left <= 0;
                        walk_right <= 0;
                        aaah <= 0;
                        digging <= 0;
                    end
                    else begin
                        // Resume walking in the previous direction
                        if (walk_left) begin
                            current_state <= STATE_WALK_LEFT;
                        end
                        else begin
                            current_state <= STATE_WALK_RIGHT;
                        end
                    end
                end
            end

            STATE_DIG: begin
                walk_left <= 0;
                walk_right <= 0;
                aaah <= 0;
                digging <= 1;

                if (!ground) begin
                    current_state <= STATE_FALL;
                end
                else if (!dig) begin
                    current_state <= (walk_left) ? STATE_WALK_LEFT : STATE_WALK_RIGHT;
                end
            end

            default: begin
                // Invalid state, reset the FSM
                current_state <= STATE_WALK_LEFT;
                walk_left <= 1;
                walk_right <= 0;
                aaah <= 0;
                digging <= 0;
                fall_count <= 0;
            end
        endcase
    end
end

endmodule
