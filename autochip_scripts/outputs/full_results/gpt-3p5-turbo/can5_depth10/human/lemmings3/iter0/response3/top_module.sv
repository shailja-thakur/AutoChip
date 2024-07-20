module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging
);

    // Enum for the possible states of the Lemming
    typedef enum logic [1:0] {
        WALK_LEFT,
        WALK_RIGHT,
        FALL,
        DIG
    } State;

    // State register to hold the current state of the Lemming
    logic [1:0] state_reg;
    // Next state register to hold the next state to transition to
    logic [1:0] next_state_reg;

    // Output registers
    logic walk_left_reg;
    logic walk_right_reg;
    logic aaah_reg;
    logic digging_reg;

    // State transition and output logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            // Reset the state machine to the initial state
            state_reg <= WALK_LEFT;
            next_state_reg <= WALK_LEFT;
        end else begin
            // Update current state
            state_reg <= next_state_reg;

            // Default values for outputs
            walk_left_reg <= 1'b0;
            walk_right_reg <= 1'b0;
            aaah_reg <= 1'b0;
            digging_reg <= 1'b0;

            // State transition and output logic
            case (state_reg)
                WALK_LEFT: begin
                    if (bump_right) begin
                        // Switch direction if bumped on the right
                        next_state_reg <= WALK_RIGHT;
                    end else if (ground == 1'b0) begin
                        // Fall if not on ground
                        next_state_reg <= FALL;
                        aaah_reg <= 1'b1;
                    end else if (dig) begin
                        // Start digging if on ground and dig signal is received
                        next_state_reg <= DIG;
                        digging_reg <= 1'b1;
                    end
                end
                WALK_RIGHT: begin
                    if (bump_left) begin
                        // Switch direction if bumped on the left
                        next_state_reg <= WALK_LEFT;
                    end else if (ground == 1'b0) begin
                        // Fall if not on ground
                        next_state_reg <= FALL;
                        aaah_reg <= 1'b1;
                    end else if (dig) begin
                        // Start digging if on ground and dig signal is received
                        next_state_reg <= DIG;
                        digging_reg <= 1'b1;
                    end
                end
                FALL: begin
                    if (ground) begin
                        // Resume walking in the same direction if ground reappears
                        if (state_reg == WALK_LEFT) begin
                            next_state_reg <= WALK_LEFT;
                        end else begin
                            next_state_reg <= WALK_RIGHT;
                        end
                    end
                end
                DIG: begin
                    if (ground == 1'b0) begin
                        // Continue digging until the other side is reached and then fall
                        next_state_reg <= DIG;
                        digging_reg <= 1'b1;
                        aaah_reg <= 1'b1;
                    end else begin
                        // Resume walking in the same direction if ground reappears
                        if (state_reg == WALK_LEFT) begin
                            next_state_reg <= WALK_LEFT;
                        end else begin
                            next_state_reg <= WALK_RIGHT;
                        end
                    end
                end
            endcase
        end
    end

    // Assign outputs to registers
    assign walk_left = walk_left_reg;
    assign walk_right = walk_right_reg;
    assign aaah = aaah_reg;
    assign digging = digging_reg;

endmodule
