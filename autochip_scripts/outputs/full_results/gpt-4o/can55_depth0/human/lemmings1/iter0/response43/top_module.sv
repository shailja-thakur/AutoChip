module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

    // Define the states
    typedef enum logic {LEFT, RIGHT} state_t;
    state_t state, next_state;

    // State transition and next state logic
    always @(*) begin
        case(state)
            LEFT: begin
                if (bump_left) next_state = RIGHT;
                else next_state = LEFT;
            end
            RIGHT: begin
                if (bump_right) next_state = LEFT;
                else next_state = RIGHT;
            end
            default: next_state = LEFT;  // Default state
        endcase
    end

    // State registers and output logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= LEFT;
        end else begin
            state <= next_state;
        end
    end

    // Output logic
    always @(*) begin
        case(state)
            LEFT: begin
                walk_left = 1;
                walk_right = 0;
            end
            RIGHT: begin
                walk_left = 0;
                walk_right = 1;
            end
            default: begin
                walk_left = 1;
                walk_right = 0;
            end
        endcase
    end

endmodule
