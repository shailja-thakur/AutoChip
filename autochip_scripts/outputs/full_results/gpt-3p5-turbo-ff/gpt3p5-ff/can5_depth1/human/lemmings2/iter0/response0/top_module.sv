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

    // Define the states
    typedef enum {WALK_LEFT, WALK_RIGHT, FALLING} state_t;
    reg [1:0] state;

    // Initialize output registers
    initial begin
        walk_left = 1;
        walk_right = 0;
        aaah = 0;
    end

    // Define the state transitions and outputs
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WALK_LEFT;
            walk_left <= 1;
            walk_right <= 0;
            aaah <= 0;
        end else begin
            case (state)
                WALK_LEFT: begin
                    if (bump_right && !bump_left)
                        state <= WALK_RIGHT;
                    else if (!bump_right && bump_left)
                        state <= WALK_LEFT;
                    else if (bump_right && bump_left)
                        state <= WALK_RIGHT;
                    else if (!ground)
                        state <= FALLING;
                end

                WALK_RIGHT: begin
                    if (bump_right && !bump_left)
                        state <= WALK_RIGHT;
                    else if (!bump_right && bump_left)
                        state <= WALK_LEFT;
                    else if (bump_right && bump_left)
                        state <= WALK_LEFT;
                    else if (!ground)
                        state <= FALLING;
                end

                FALLING: begin
                    if (ground) begin
                        state <= (walk_left) ? WALK_LEFT : WALK_RIGHT;
                    end else begin
                        state <= FALLING;
                    end
                end
            endcase
        end
    end

    // Define the outputs based on the current state
    always @(state, ground) begin
        case (state)
            WALK_LEFT: begin
                walk_left <= 1;
                walk_right <= 0;
                aaah <= 0;
            end

            WALK_RIGHT: begin
                walk_left <= 0;
                walk_right <= 1;
                aaah <= 0;
            end

            FALLING: begin
                walk_left <= 0;
                walk_right <= 0;
                aaah <= 1;
            end
        endcase
    end

endmodule
