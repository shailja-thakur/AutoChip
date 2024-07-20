module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

    // Define states
    typedef enum reg [1:0] {
        LEFT = 2'b01,
        RIGHT = 2'b10
    } state_t;

    state_t state, next_state;

    // Asynchronous reset and state transition logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= LEFT;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic based on current state and inputs
    always @(*) begin
        case (state)
            LEFT: begin
                if (bump_left) begin
                    next_state = RIGHT;
                end else begin
                    next_state = LEFT;
                end
            end
            RIGHT: begin
                if (bump_right) begin
                    next_state = LEFT;
                end else begin
                    next_state = RIGHT;
                end
            end
            default: next_state = LEFT; // Default state
        endcase
    end

    // Output logic based on the current state
    always @(*) begin
        walk_left = (state == LEFT);
        walk_right = (state == RIGHT);
    end

endmodule
