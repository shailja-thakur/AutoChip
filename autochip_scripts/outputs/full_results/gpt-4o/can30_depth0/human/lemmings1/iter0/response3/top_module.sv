module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right
);
    // Define the states
    typedef enum logic [1:0] {
        LEFT = 2'b01,  // Lemming is walking left
        RIGHT = 2'b10  // Lemming is walking right
    } state_t;

    // State registers
    state_t state, next_state;

    // Output logic
    assign walk_left = (state == LEFT);
    assign walk_right = (state == RIGHT);

    // State transition logic
    always @(*) begin
        case (state)
            LEFT: begin
                if (bump_left) begin
                    next_state = RIGHT;  // Switch to walking right
                end else begin
                    next_state = LEFT;   // Continue walking left
                end
            end
            RIGHT: begin
                if (bump_right) begin
                    next_state = LEFT;   // Switch to walking left
                end else begin
                    next_state = RIGHT;  // Continue walking right
                end
            end
            default: next_state = LEFT;
        endcase
    end

    // Sequential logic for state update
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= LEFT;  // Reset to walking left
        end else begin
            state <= next_state;  // Update state
        end
    end

endmodule
