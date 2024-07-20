module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah
);

    // Define the states
    typedef enum logic [1:0] {
        WALK_LEFT,
        WALK_RIGHT,
        FALL,
    } state_t;

    // Define the signals
    logic [1:0] state;
    logic walk_left_int;
    logic walk_right_int;
    logic aaah_int;

    // Initialize the signals
    initial begin
        state = WALK_LEFT;
        walk_left_int = 1;
        walk_right_int = 0;
        aaah_int = 0;
    end

    // Define the state transition and output logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            // Asynchronous reset
            state <= WALK_LEFT;
            walk_left_int <= 1;
            walk_right_int <= 0;
            aaah_int <= 0;
        end else begin
            // Sequential logic
            case (state)
                WALK_LEFT:
                    if (bump_right) begin
                        // If bumped on the right, switch to walking right state
                        state <= WALK_RIGHT;
                        walk_left_int <= 0;
                        walk_right_int <= 1;
                        aaah_int <= 0;
                    end else if (!ground) begin
                        // If not grounded, switch to falling state
                        state <= FALL;
                        walk_left_int <= 0;
                        walk_right_int <= 0;
                        aaah_int <= 1;
                    end
                WALK_RIGHT:
                    if (bump_left) begin
                        // If bumped on the left, switch to walking left state
                        state <= WALK_LEFT;
                        walk_left_int <= 1;
                        walk_right_int <= 0;
                        aaah_int <= 0;
                    end else if (!ground) begin
                        // If not grounded, switch to falling state
                        state <= FALL;
                        walk_left_int <= 0;
                        walk_right_int <= 0;
                        aaah_int <= 1;
                    end
                FALL:
                    if (ground) begin
                        // If grounded, switch back to walking in the same direction as before falling
                        if (state == WALK_LEFT) begin
                            state <= WALK_LEFT;
                            walk_left_int <= 1;
                            walk_right_int <= 0;
                            aaah_int <= 0;
                        end else if (state == WALK_RIGHT) begin
                            state <= WALK_RIGHT;
                            walk_left_int <= 0;
                            walk_right_int <= 1;
                            aaah_int <= 0;
                        end
                    end else if (bump_right || bump_left) begin
                        // If bumped while falling, ignore the bump
                        state <= FALL;
                        walk_left_int <= 0;
                        walk_right_int <= 0;
                        aaah_int <= 1;
                    end
            endcase
        end
    end

    // Assign output signals
    assign walk_left = walk_left_int;
    assign walk_right = walk_right_int;
    assign aaah = aaah_int;

endmodule
